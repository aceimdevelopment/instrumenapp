# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_10_151825) do

  create_table "administradores", primary_key: "usuario_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "rol", null: false
    t.string "departamento_id"
    t.string "escuela_id"
    t.index ["departamento_id"], name: "index_administradores_on_departamento_id"
    t.index ["escuela_id"], name: "index_administradores_on_escuela_id"
    t.index ["usuario_id"], name: "index_administradores_on_usuario_id"
  end

  create_table "area_courses", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "area_id", null: false
    t.index ["area_id", "course_id"], name: "index_area_courses_on_area_id_and_course_id"
    t.index ["course_id", "area_id"], name: "index_area_courses_on_course_id_and_area_id"
  end

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "asignaturas", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "descripcion"
    t.integer "anno"
    t.integer "orden"
    t.integer "calificacion", default: 0
    t.boolean "activa", default: false
    t.string "departamento_id", null: false
    t.string "catedra_id", null: false
    t.string "tipoasignatura_id", null: false
    t.string "id_uxxi"
    t.integer "creditos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pci", default: false, null: false
    t.index ["catedra_id"], name: "index_asignaturas_on_catedra_id"
    t.index ["departamento_id"], name: "index_asignaturas_on_departamento_id"
    t.index ["id"], name: "index_asignaturas_on_id"
    t.index ["tipoasignatura_id"], name: "index_asignaturas_on_tipoasignatura_id"
  end

  create_table "bitacoras", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comentario"
    t.string "descripcion"
    t.string "usuario_id"
    t.string "id_objeto"
    t.string "tipo_objeto"
    t.string "ip_origen"
    t.integer "tipo", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_bitacoras_on_usuario_id"
  end

  create_table "carteleras", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "contenido"
    t.boolean "activa", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catedradepartamentos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "departamento_id"
    t.string "catedra_id"
    t.integer "orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catedra_id", "departamento_id"], name: "index_catedradepartamentos_on_catedra_id_and_departamento_id", unique: true
    t.index ["catedra_id"], name: "index_catedradepartamentos_on_catedra_id"
    t.index ["departamento_id", "catedra_id"], name: "index_catedradepartamentos_on_departamento_id_and_catedra_id", unique: true
    t.index ["departamento_id"], name: "index_catedradepartamentos_on_departamento_id"
  end

  create_table "catedras", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "descripcion"
    t.integer "orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_catedras_on_id"
  end

  create_table "citahorarias", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "fecha", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combinaciones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "estudiante_id"
    t.string "periodo_id"
    t.string "idioma1_id"
    t.string "idioma2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estudiante_id", "periodo_id"], name: "index_combinaciones_on_estudiante_id_and_periodo_id", unique: true
    t.index ["estudiante_id"], name: "index_combinaciones_on_estudiante_id"
    t.index ["idioma1_id"], name: "index_combinaciones_on_idioma1_id"
    t.index ["idioma2_id"], name: "index_combinaciones_on_idioma2_id"
    t.index ["periodo_id", "estudiante_id"], name: "index_combinaciones_on_periodo_id_and_estudiante_id", unique: true
    t.index ["periodo_id"], name: "index_combinaciones_on_periodo_id"
  end

  create_table "departamentos", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "descripcion"
    t.string "escuela_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["escuela_id"], name: "index_departamentos_on_escuela_id"
    t.index ["id"], name: "index_departamentos_on_id"
  end

  create_table "escuelaestudiantes", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "escuela_id"
    t.string "estudiante_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["escuela_id", "estudiante_id"], name: "index_escuelaestudiantes_on_escuela_id_and_estudiante_id", unique: true
    t.index ["escuela_id"], name: "index_escuelaestudiantes_on_escuela_id"
    t.index ["estudiante_id", "escuela_id"], name: "index_escuelaestudiantes_on_estudiante_id_and_escuela_id", unique: true
    t.index ["estudiante_id"], name: "index_escuelaestudiantes_on_estudiante_id"
  end

  create_table "escuelaperiodos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "periodo_id"
    t.string "escuela_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["escuela_id", "periodo_id"], name: "index_escuelaperiodos_on_escuela_id_and_periodo_id", unique: true
    t.index ["escuela_id"], name: "index_escuelaperiodos_on_escuela_id"
    t.index ["periodo_id", "escuela_id"], name: "index_escuelaperiodos_on_periodo_id_and_escuela_id", unique: true
    t.index ["periodo_id"], name: "index_escuelaperiodos_on_periodo_id"
  end

  create_table "escuelas", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_escuelas_on_id"
  end

  create_table "escuelas_estudiantes", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "estudiante_id", null: false
    t.bigint "escuela_id", null: false
    t.index ["escuela_id", "estudiante_id"], name: "index_escuelas_estudiantes_on_escuela_id_and_estudiante_id"
    t.index ["estudiante_id", "escuela_id"], name: "index_escuelas_estudiantes_on_estudiante_id_and_escuela_id"
  end

  create_table "escuelas_usuarios", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "escuela_id", null: false
    t.index ["escuela_id", "usuario_id"], name: "index_escuelas_usuarios_on_escuela_id_and_usuario_id"
    t.index ["usuario_id", "escuela_id"], name: "index_escuelas_usuarios_on_usuario_id_and_escuela_id"
  end

  create_table "estudiantes", primary_key: "usuario_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tipo_estado_inscripcion_id"
    t.boolean "activo", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "citahoraria_id"
    t.index ["citahoraria_id"], name: "index_estudiantes_on_citahoraria_id"
    t.index ["tipo_estado_inscripcion_id"], name: "index_estudiantes_on_tipo_estado_inscripcion_id"
    t.index ["usuario_id"], name: "index_estudiantes_on_usuario_id"
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type", null: false
    t.string "title"
    t.date "start", null: false
    t.string "location"
    t.bigint "schedule_id"
    t.string "cost"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_evaluations_on_schedule_id"
  end

  create_table "general_parameters", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value", null: false
    t.index ["id"], name: "index_general_parameters_on_id"
  end

  create_table "inscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "score", default: 0
    t.string "baucher"
    t.integer "status", default: 0
    t.integer "evatype", null: false
    t.string "language_id", null: false
    t.bigint "area_id"
    t.string "user_id", null: false
    t.bigint "evaluation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_inscriptions_on_area_id"
    t.index ["evaluation_id"], name: "index_inscriptions_on_evaluation_id"
    t.index ["language_id"], name: "index_inscriptions_on_language_id"
    t.index ["user_id"], name: "index_inscriptions_on_user_id"
  end

  create_table "languages", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_languages_on_id"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.integer "evatype", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "phone"
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.index ["id"], name: "index_users_on_id"
  end

  add_foreign_key "administradores", "departamentos", name: "administradores_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "administradores", "escuelas", name: "administradores_ibfk_1", on_update: :cascade, on_delete: :nullify
  add_foreign_key "administradores", "usuarios", primary_key: "ci", name: "administradores_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asignaturas", "catedras", name: "asignaturas_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asignaturas", "departamentos", name: "asignaturas_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "asignaturas", "tipoasignaturas", name: "asignaturas_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "catedradepartamentos", "catedras", name: "catedradepartamentos_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "catedradepartamentos", "departamentos", name: "catedradepartamentos_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "combinaciones", "departamentos", column: "idioma1_id", name: "combinaciones_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "combinaciones", "departamentos", column: "idioma2_id", name: "combinaciones_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "combinaciones", "estudiantes", primary_key: "usuario_id", name: "combinaciones_ibfk_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "combinaciones", "periodos", name: "combinaciones_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "departamentos", "escuelas", name: "departamentos_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "escuelaestudiantes", "escuelas", name: "escuelaestudiantes_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "escuelaestudiantes", "estudiantes", primary_key: "usuario_id", name: "escuelaestudiantes_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "escuelaperiodos", "escuelas", name: "escuelaperiodos_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "escuelaperiodos", "periodos", name: "escuelaperiodos_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "estudiantes", "citahorarias", name: "estudiantes_ibfk_1", on_update: :cascade, on_delete: :nullify
  add_foreign_key "estudiantes", "usuarios", primary_key: "ci", name: "estudiantes_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "evaluations", "schedules", name: "evaluations_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "areas", name: "inscriptions_ibfk_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "evaluations", name: "inscriptions_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "languages", name: "inscriptions_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "users", name: "inscriptions_ibfk_2", on_update: :cascade, on_delete: :cascade
end
