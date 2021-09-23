# frozen_string_literal: true

# class for working with images
class Image
  ALLOWED_TYPES = [
    'image/apng',
    'image/avif',
    'image/gif',
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/svg+xml'
  ].freeze

  MAX_LIMIT_MB = 1
  MAX_LIMIT = MAX_LIMIT_MB * 1024 * 1024
end
