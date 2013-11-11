require 'fileutils'

class UploadsController < ApplicationController
  def create
    uploaded_io = params[:file]
    upload_path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    orig_path = upload_path
    i = 0
    while upload_path.exist?
      i = i + 1
      new_name = "#{orig_path.basename(".*")}_#{i}#{upload_path.extname}"
      upload_path = Rails.root.join('public', 'uploads', new_name)
    end
    FileUtils.mkdir_p upload_path.dirname unless upload_path.dirname.exist?
    File.open(upload_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    return render json: {name: upload_path.basename}
  end

  def delete
  end
end
