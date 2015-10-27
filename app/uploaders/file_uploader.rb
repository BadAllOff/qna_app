# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  delegate :identifier, to: :file# проксирует вызовы к обекту внутреннему file

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  version :thumb do
    process resize_to_limit: [100, 100]
  end

end
