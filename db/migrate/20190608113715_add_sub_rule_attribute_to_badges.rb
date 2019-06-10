class AddSubRuleAttributeToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :sub_rule, :string
  end
end
