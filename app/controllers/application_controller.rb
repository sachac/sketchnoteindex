class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => [:show, :index]

  protected
  def filter_sortable_order(columns, default_order)
    sortable_column_order do |column, direction|
      if columns.include? column
        "#{column} #{direction}"
      else
        default_order
      end
    end
  end
end
