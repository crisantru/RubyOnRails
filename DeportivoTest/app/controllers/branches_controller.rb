class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]

  # GET /branches
  # GET /branches.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end  

    @branches = Branch.all
      
      
      
    if not session[:branch_id].nil?
        @sucursales = Branch.where("branch_id = ?", session[:branch_id])
    elsif not session[:branch_state].nil?
        @sucursales = Branch.where("state LIKE '%#{session[:branch_state]}%'")
    elsif not session[:branch_name].nil?
        @sucursales = Branch.where("name LIKE '%#{session[:branch_name]}%'")
    else
        @sucursales = nil
        
        
    end
      
      
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end      
  end

  # GET /branches/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end  

    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  def buscar_por_id
      session.delete(:branch_state)
      session.delete(:branch_name)
      branch = Branch.where("branch_id = ?", params[:branch])
      session[:branch_id] = params[:branch]
      
      #Devuelve un json como salida al navegador.
      render :json => branch[0]   
      
      
    end
    
  def buscar_por_state
  session.delete(:branch_id)
  session.delete(:branch_name)
  state = Branch.where("state LIKE '%#{params[:state]}%'")
  session[:branch_state] = params[:state]

  #Devuelve un json como salida al navegador.
  render :json => state[0]

  end


  def buscar_por_name
  session.delete(:branch_id)
  session.delete(:branch_state)
  name = Branch.where("name LIKE '%#{params[:name]}%'")
  session[:branch_name] = params[:name]

  #Devuelve un json como salida al navegador.
  render :json => name[0]

  end


    
    
  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to new_branch_path, notice: 'Solo el administrador puede crear una Sucursal' }
        #format.json { render :show, location: @branch }      
      elsif @branch.save
        format.html { redirect_to @branch }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      # Solo el administrador puede actualizar
      if not session[:tipo_usuario] == 1
        format.html { redirect_to branches_path, notice: 'Sin permisos para editar, por favor inice como administrador' }
        #format.json { render :show, location: @branch }
      elsif @branch.update(branch_params)
        format.html { redirect_to @branch }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        # Solo el administrador puede eliminar
        format.html { redirect_to branches_path, notice: 'Sin permisos para eliminar, por favor inice como administrador' }
        #format.json { render :show, location: @branch }
      else    
        @branch.destroy  
        format.html { redirect_to branches_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params[:branch].permit(:name, :address, :state, :city ,:phone)
    end
end
