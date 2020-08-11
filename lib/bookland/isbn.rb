# frozen_string_literal: true

require 'structure'

require 'bookland/isbn/check_digit'
require 'bookland/isbn/range/message'

# The International Standard Book Number is a unique numeric identification
# system for commercial books.
#
# @see https://www.isbn-international.org/content/what-isbn
# @see https://www.kb.se/download/18.71dda82e160c04f1cc412bc/1531827912246/ISBN%20International%20Users%20Manual%20-%207th%20edition.pdf
class ISBN
  include Structure

  class << self
    # @return [Bookland::ISBN::Range::Message] an ISBN range message provided
    #   by the International ISBN Agency
    attr_accessor :range_message
  end

  attr_reader :digits

  # @param value [#to_s] a value that we expect to represent an ISBN
  def initialize(value)
    @digits = value.to_s.tr(' -', '')
  end

  # @!attribute [r]
  # @return [ISBN::Range::GS1]
  attribute :gs1 do
    prefix = if isbn13like?
               digits.slice(0, 3)
             elsif isbn10like?
               '978'
             end

    range_message.find_gs1(prefix)
  end

  # @!attribute [r]
  # @return [ISBN::Range::RegistrationGroup]
  attribute :registration_group do
    return unless gs1

    slice = digits.slice(isbn13like? ? 3 : 0, 7)
    prefix = gs1.find_next_prefix(slice)

    range_message.find_registration_group(prefix) if prefix
  end

  # @!attribute [r]
  # @return [String] a particular publisher or imprint within a registration
  #   group
  attribute :registrant do
    return unless registration_group

    start = (isbn13like? ? 3 : 0) + registration_group.to_s.length
    registration_group.find_next_element(digits.slice(start, 7))

    prefix = "#{gs1}-#{digits.slice(3, rule.length)}"

    range_message.registration_groups.find { |rg| rg.prefix == prefix }
  end

  # @!attribute [r]
  # @return [String] a specific edition of a publication by a specific
  #   publisher
  attribute :publication do
  end

  # @!attribute [r]
  # @return [Bookland::ISBN::CheckDigit] a check digit calculated using a
  #   modulus 10 algorithm
  attribute :check_digit do
  end

  # @param separator [String]
  # @return [String] a formatted string representing the ISBN
  def to_s(separator = '-')
    return unless valid?

    [gs1, registration_group, registrant, publication, check_digit]
      .join(separator)
  end

  def registration_group
    prefix = "#{gs1_element}-#{registration_group_element}"
    range_message.registration_groups.find { |group| group.prefix == prefix }
  end

  def registration_group_rule
    gs1.find_rule(digits.slice(3, 7))
  end

  def registrant_rule
    start = 3 + registration_group_element.length
    registration_grup.find_rule(digits.slice(start, 7))
  end

  # @!attribute [r]
  # @return [Bookland::ISBN::Range::RegistrationGroup]
  attribute :registration_group do
    return unless gs1

    return unless (rule = gs1.rules.find { |r| r.cover?(digits.slice(3, 7)) })

    range_message.registration_groups.find { |rg| rg.prefix == [gs1_prefix, digits.slice(3, rule.length)].join('-') }
  end

  # @!attribute [r]
  # @return [Boolean]
  attribute :isbn10like? do
    @digits.match?(/^\d{9}[\dX]?$/)
  end

  private

  def gs1_length
    isbn10like? ? 0 : 3
  end

  def find_registration_group_rule
    return unless gs1

    gs1.rules.find { |rule| rule.cover?(digits.slice(3, 7)) }
  end

  # A language-sharing country group, individual country, or territory
  # @!attribute [r]
  # @return [String, nil]
  attribute :agency do
    return if agency_element_length.zero?

    @digits.slice(gs1_prefix_length, agency_element_length)
  end

  # @!attribute [r]
  # @return [String, nil]
  attribute :publisher do
    return if publisher_length.zero?

    @digits.slice(gs1_prefix_length + agency_element_length, publisher_length)
  end

  # @!attribute [r]
  # @return [String, nil]
  attribute :publication do
    return unless publisher_element

    @digits.slice(gs1_prefix_length + agency_element_length +
                  publisher_length..-2)
  end

  # @!attribute [r]
  # @return [Bookland::ISBN::CheckDigit]
  attribute :check_digit do
    CheckDigit.new(@digits)
  end

  # Converts object to an ISBN-13
  # @raise [Bookland::ISBN::Error] if ISBN is not valid
  # @return [Bookland::ISBN]
  def isbn13
    validate!
    return self if isbn13like?

    ISBN.new(['978', agency_element, publisher_element, publication_element]
      .join)
  end

  # Converts object to an ISBN-10
  # @raise [Bookland::ISBN::Error] if ISBN is not valid or is prefixed with
  #   979
  # @return [Bookland::ISBN]
  def isbn10
    validate!
    return self if isbn10like?
    if gs1_prefix == '979'
      raise Error, "can't convert 979-prefixed ISBN to ISBN-10"
    end

    ISBN.new([agency_element, publisher_element, publication_element].join)
  end

  # Validates the format, agency, publisher, and check digit of the ISBN
  # @return [true]
  # @raise [Bookland::ISBN::Error]
  def validate!
    raise Error, 'bad format' unless isbnlike?
    raise Error, 'agency not found' unless agency_element
    raise Error, 'publisher not found' unless publisher_element
    raise Error, 'invalid check digit' unless check_digit.valid?

    true
  end

  # Returns whether the format, agency, publisher, and check digit of the ISBN
  # are valid
  # @return [Boolean]
  def valid?
    validate!
  rescue Error
    false
  end

  def split
    if isbn13like?
      [gs1, agency, publisher, publication, check_digit]
    elsif isbn10like?
      [agency, publisher, publication, check_digit]
    end
  end

  def isbnlike?
    isbn13like? || isbn10like?
  end

  def isbn10like?
    @digits.match?(/^\d{9}[\dX]?$/)
  end

  def isbn13like?
    @digits.match?(/^(?:978|979)\d{9,10}$/)
  end

  def gs1_prefix_length
    @gs1_prefix_length ||= isbn13like? ? 3 : 0
  end

  def agency_element_length
    @agency_element_length ||= registration_group&.agency_element_length || 0
  end

  def publisher_length
    @publisher_length ||= rule&.length || 0
  end

  def registration_group
    gs1_prefix ||= '978'
    1.upto(5).each do |length|
      key2 = @digits.slice(gs1_prefix_length, length)
      found = lookup_table.dig(key1, key2)
      return found if found
    end

    nil
  end

  def rule
    key = @digits.slice(gs1_prefix_length + agency_element_length..-2)
    registration_group.rules.find { |rule| rule.cover?(key) }
  end

  # @range_message = Range.message
end
