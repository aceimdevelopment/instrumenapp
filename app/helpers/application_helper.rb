module ApplicationHelper
    def is_active_controller(controller_name, class_name = nil)
        if params[:controller] == controller_name
         class_name == nil ? "active" : class_name
        else
           nil
        end
    end

    def label_state_record inscription

        content_tag :span, class: "label label-#{inscription.alert_type}" do
            description = inscription.status.titleize
            description += " (Asignado)" if inscription.preinscrito? and inscription.evaluation and inscription.evaluation.title 
            capture_haml{description}
        end
        
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    # def modal_to id, tittle, body
    #     capture_haml do 


    #     .modal.fade{'aria-hidden': true, tabindex: '-1'}
    #       .modal-dialog
    #         .modal-content
    #           .alert.alert-info
    #             %button.close{'aria-label': 'Cerrar', 'data-dismiss': :modal, type: :button}
    #               %span{'aria-hidden': true} ×
    #             .text-center= 
    #           .text-center.loginscreen
    #             %h1.logo-name EIM
    #             %h3 Escuela de Idiomas Modernos
    #             %h4 UNIVERSIDAD CENTRAL DE VENEZUELA
    #             %h5.text-muted Cursos y Pruebas Instrumentales

    #           .modal-body


        
    # end


    def inscriptions_buttons id=nil
        path = id ? "&id=#{id}" : ""  

        aux = link_to "#{new_inscription_path}?test=true#{path}", class: 'btn btn-success btn-block m-b-1' do 
            capture_haml{"<i class='fa fa-graduation-cap'></i> Inscribir Prueba de Dominio Instrumental Idioma Extrangero"}
        end
        aux += link_to "#{new_inscription_path}?course=true#{path}", class: 'btn btn-success btn-block m-b-2' do
            capture_haml{"<i class='fa fa-graduation-cap'></i> Realizar Curso Instrumental Inglés"}
        end

        return aux

    end

    def b_tooltip title, value
        content_tag :b, class: 'tooltip-btn', 'data_toggle': :tooltip, title: title do
            capture_haml{"#{value}"}
        end
    end
end
