class AddNotNullToReportsColumn < ActiveRecord::Migration[8.0]
  def change
    change_column_null :reports, :title, false
    change_column_null :reports, :content, false
    change_column_null :reports, :target_date, false
  end
end
