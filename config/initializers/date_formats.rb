date_format = {
  :mdy => '%B %d, %Y', # "December 31, 2010"
  :db => '%Y-%m-%d', # "2010-12-31"
}
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_format)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_format)