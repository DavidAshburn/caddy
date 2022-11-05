class AddParsToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :pars, :string
  end
end
