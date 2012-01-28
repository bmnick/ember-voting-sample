class ChangeCandidateNameToDisplayName < ActiveRecord::Migration
  def change
  	rename_column :candidates, :name, :displayName
  end
end
