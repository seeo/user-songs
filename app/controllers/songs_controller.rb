class SongsController < ApplicationController
before_action :authenticate_user!, :except => [ :show, :index ]

  def index

    @songs = Song.all
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
    cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    p cloudinary_file
    p cloudinary_file["public_id"]
    @song.attributes = {:public_id => cloudinary_file["public_id"]}
    #store this public_id value to the database

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

    if @song.update(song_params)
      redirect_to @song
    else
      render 'edit'
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    redirect_to articles_path
  end

  private
    def song_params
      params.require(:song).permit(:title)
    end
end
