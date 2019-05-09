class SongsController < ApplicationController
before_action :authenticate_user!, #:except => [ :show]

  def index
    @songs = current_user.songs
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  def show
    @song = Song.find(params[:id])

    p @song
    respond_to do |format|
      format.html
      format.json { render json: @song }
    end
  end

  def new
    @song = Song.new
  end

  def edit
    @song = Song.find(params[:id])
  end

  def create
    @song = Song.new(song_params)
    uploaded_file = params[:song][:picture].path
    p params
    p uploaded_file
    cloudinary_file = Cloudinary::Uploader.upload(uploaded_file, :folder => "user-songs")
    p cloudinary_file
    p cloudinary_file["public_id"]
    #store this public_id value to the database
    @song.attributes = {:image => cloudinary_file["public_id"]}
    @song.attributes = {:user_id => current_user.id}


    # render json: cloudinary_file
    # @song["public_id"] = cloudinary_file["public_id"]
    p @song
    if @song.save
      redirect_to @song
    else
      render 'new'
    end
  end

  def update
    @song = Song.find(params[:id])

    if params[:song][:picture]
      uploaded_file = params[:song][:picture].path
      p uploaded_file
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file, :folder => "user-songs")

      p cloudinary_file
      p cloudinary_file["url"]

      @song.attributes = {:image => cloudinary_file["public_id"]}
    else
      song_params[:image] = @song.image
    end

    if @song.update(song_params)
      redirect_to @song
    else
      render 'songs/edit'
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  private
    def song_params
      params.require(:song).permit(:title, :hours, :image)
    end
end
