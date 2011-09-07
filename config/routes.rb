Rails.application.routes.draw do

  scope ENV['RAILS_RELATIVE_URL_ROOT'] || '/' do
    namespace(:admin_data) do
      scope :admin_data do
        controller "migration" do
          match '/migration', :to => :index,  :as => :migration_information
          match '/jstest',    :to => :jstest, :as => :jstest
        end

        match '/table_structure/(:klass)' => "table_structure#index",  :as => :table_structure

        match '/quick_search/(:klass)'    => "search#quick_search",    :as => :search
        match '/quick_search'             => "search#quick_search"

        match '/advance_search/(:klass)'  => "search#advance_search",  :as => :advance_search
        match '/advance_search'           => "search#advance_search"

        match '/analytics/daily/(:klass)'       => "analytics#daily",        :as => :daily_analytics
        match '/analytics/monthly/(:klass)'     => "analytics#monthly",      :as => :monthly_analytics

        controller "crud" do
          match '/klass/(:klass)/new',              :to => :new,              :as => :new,     :via => :get  
          match '/klass/(:klass)/:id/del',          :to => :del,              :as => :del,     :via => :delete
          match '/klass/(:klass)/:id/edit',         :to => :edit,             :as => :edit,    :via => :get
          match '/klass/(:klass)/:id',              :to => :show,             :via => :get
          match '/klass/(:klass)/:id',              :to => :update,           :via => :put
          match '/klass/(:klass)/:id',              :to => :destroy,          :via => :delete
          match '/klass/(:klass)',                  :to => :index,            :as => :index,   :via => :get
          match '/klass/(:klass)',                  :to => :create,           :as => :index,   :via => :post
        end

        match '/feed/(:klasss)'           => "feed#index", :defaults => { :format =>'rss' }, :as => :feed

        match '/public/*file'             => "public#serve", :as => :public

        root :to => "home#index"
      end
    end
  end

end
