class CreateJoinTableCourseArea < ActiveRecord::Migration[5.2]
  def change
    create_join_table :courses, :areas, table_name: 'area_courses' do |t|
      t.index [:course_id, :area_id]
      t.index [:area_id, :course_id]
    end

    # add_foreign_key :area_courses, :areas, on_delete: :cascade, on_update: :cascade
    # add_foreign_key :area_courses, :evaluations, on_delete: :cascade, on_update: :cascade, foreign_key: :course_id#, table_name: 'evaluations'

  end
end
