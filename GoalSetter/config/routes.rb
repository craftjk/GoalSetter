GoalSetter::Application.routes.draw do
  resources :users do
    resources :goals
  end
  resource :session
end
