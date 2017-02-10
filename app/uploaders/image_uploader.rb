# frozen_string_literal: true
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage (Rails.env.production? ? :fog : :file)

  def extension_white_list
    %w(jpg jpeg gif png)
   end

  def default_url(*_args)
    '/assets/exercise.jpg'
  end

  version :small do
    process resize_to_fill: [150, 150]
  end

  version :large do
    process resize_to_fill: [500, 500]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
