defmodule BettingWeb.Router do

  use BettingWeb, :router

  import BettingWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BettingWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BettingWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", HomepageLive

  end

  # Other scopes may use custom stacks.
  # scope "/api", BettingWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:betting, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BettingWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BettingWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{BettingWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", BettingWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{BettingWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

       #BETS LIVE VIEWS
       live "/bets", BetLive.Index, :index
       live "/bets/new/:match_id", BetLive.Index, :new
       live "/bets/:id/edit/:match_id", BetLive.Index, :edit

       live "/bets/:id", BetLive.Show, :show
      #  live "/bets/:id/show/edit", BetLive.Show, :edit



    end
  end

   # ADMIN SPECIFIC ROUTES.
   scope "/", BettingWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_admin,
    on_mount: [
      {BettingWeb.UserAuth, :ensure_authenticated},
      {BettingWeb.UserAuth, :ensure_admin}
    ] do

      #USERS PAGES.
      live "/users", UserLive.Index, :index
      live "/users/:id", UserLive.Show, :show

    end
  end


  #SUPERUSER ADMIN SPECIFIC ROUTES.
  scope "/", BettingWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :ensure_super_user,
    on_mount: [
      {BettingWeb.UserAuth, :ensure_authenticated},
      {BettingWeb.UserAuth, :ensure_super_user}
    ] do
      # USERS PAGES.
      live "/users/:id/edit", UserLive.Index, :edit
      live "/users/:id/show/edit", UserLive.Show, :edit

      #TEAMS LIVE VIEWS
      live "/teams", TeamLive.Index, :index
      live "/teams/new", TeamLive.Index, :new
      live "/teams/:id/edit", TeamLive.Index, :edit

      live "/teams/:id", TeamLive.Show, :show
      live "/teams/:id/show/edit", TeamLive.Show, :edit


      #MATCHES LIVE VIEWS
      live "/matches", MatchLive.Index, :index
      live "/matches/new", MatchLive.Index, :new
      live "/matches/:id/edit", MatchLive.Index, :edit

      live "/matches/:id", MatchLive.Show, :show
      live "/matches/:id/show/edit", MatchLive.Show, :edit


    end
  end

  scope "/", BettingWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{BettingWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new


    end
  end
end
