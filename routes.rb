ROUTES = {
  '[GET] /make_something' => {
      pipeline: :CreateUser,
      presenter: :GenericPresenter,
      view_engine: :GenericView,
      view_name: :create_user,
      params: [:name, :other]
  },

  '[POST] /make_something_else' => {
      pipeline: :DoMagic,
      presenter: :GenericPresenter,
      view_engine: :GenericView,
      view_name: :different_name,
      params: [:other]
  },
  '[GET] /' => {
      pipeline: :OtherPipeline,
      presenter: :GenericPresenter,
      view_engine: :GenericView,
      view_name: :create_user,
      params: [:name, :other]
  },
}
