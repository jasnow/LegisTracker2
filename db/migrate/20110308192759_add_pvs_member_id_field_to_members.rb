class AddPvsMemberIdFieldToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :pvs_member_id, :integer
  end

  def self.down
    remove_column :members, :pvs_member_id
  end
end
