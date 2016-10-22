require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe '#index' do
    it 'render the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  describe '#show' do
    it 'render the show template' do
      project = create(:project)
      get :show, params: {id: project.id}
      expect(response).to render_template(:show)
    end
    it 'check if the project being rendered is the same as the one i created' do
      project = create(:project)
      get :show, params: {id: project.id}
      expect(assigns(:project)).to eq(project)
    end
  end
  describe '#destroy' do
    it 'render the show page where destroy button in presented' do
      project = create(:project)
      get :show, params: {id: project.id}
      expect(response).to render_template(:show)
    end
    it 'check if project was deleted from database' do
      project = create(:project)
      count_before = Project.count
      delete :destroy, params: {id: project.id}
      count_after = Project.count
      expect(count_before).to eq(count_after + 1)
    end
  end
  describe '#new' do
    it 'render the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'initiate a new project object' do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end
  describe '#create' do
    context 'with valid params' do
      let(:valid_params) {{project: attributes_for(:project)}}
      let(:invalid_params) {{project: attributes_for(:project, title: nil)}}
      let(:project) {FactoryGirl.create(:project, valid_params)}

      it 'saves a project to the database' do
        # count_before = Project.count
        #
        # count_after = Project.count
        # expect(count_after).to eq(count_before + 1)

        expect{post :create, valid_params}.to change{Project.count}.by(1)
      end

      it 'redirect to the project show page' do
        post :create, valid_params
        expect(response).to redirect_to(project_path(Project.last))
      end

      it 'doesn\'t save a record to the database' do
        count_before = Project.count
        post :create, invalid_params
        count_after = Project.count
        expect(count_after).to eq(count_before)

        # expect{post :create, invalid_params}.to change{Project.count}.by(0)
      end

      it 'renders the new template' do
        post :create, invalid_params
        expect(response).to render_template(:new)
      end

    end
  end
  describe '#edit' do
    it 'render the edit template' do
      project = create(:project)
      get :edit, params:{id: project.id}
      expect(response).to render_template(:edit)
    end
    it 'expect the id to be editted to be equal the one created' do
      project = create(:project)
      get :edit, params: {id: project.id}
      expect(assigns(:project)).to eq(project)
    end
  end
  describe '#update' do
    context 'with valid params' do

      it 'update the record to the database' do
        project = create(:project)
        patch :update, params: {id: project.id, project: {title: "testing the new title", body: "testing with body now"}}

        expect(project.reload.title).to eq("testing the new title")
      end
      it 'redirect to the show page' do
        project = create(:project)
        patch :update, params: {id: project.id, project: {title: "testing the new title"}}
        expect(response).to redirect_to(project_path)
      end
    end
    context 'with invalid_params' do
      it 'does not update the record to the database' do
        project = create(:project)
        count_before = Project.count
        patch :update, params: {id: project.id, project: {title: nil }}
        count_after = Project.count
        expect(count_before).to eq(count_after)
      end
      it 'renders the edit template' do
        project = create(:project)
        patch :update, params: {id: project.id, project: {title: nil }}
        expect(response).to render_template(:edit)
      end
    end
  end
end
