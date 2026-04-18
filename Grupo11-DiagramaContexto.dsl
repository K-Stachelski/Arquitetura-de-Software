workspace "BrinqueFeliz" "Diagrama de Contexto" {

    !identifiers hierarchical

    model {
    
        // Pessoas/Usuarios/Stakeholders
        admin = person "Administrador" "Gerencia o catálogo, usuários e permissões do sistema."
        cliente = person "Cliente" "Usuário que navega no catálogo e realiza compras."
        funcionario = person "Funcionário" "Colaborador que processa pedidos e realiza o atendimento."
        
        // Sistemas externos.
        sso = softwareSystem "Sistema de Autenticação SSO" {
            description "Autentica usuários via SSO"
            tags "External"
        }
        
        email = softwareSystem "Sistema de E-mail" {
            description "Envia confirmação de cadastro e compras."
            tags "External"
        }
        
        // Sistema principal.
        ss = softwareSystem "BrinqueFeliz" {
            description "Sistema Principal da Loja BrinqueFeliz."
        }
        
        // Relacionamentos.
        admin -> ss "Gerencia usuários e permissões"
        cliente -> ss "Realiza operações básicas"
        funcionario -> ss "Gerencia pedidos e atende clientes"
        
        ss -> sso "Autentica usuário"
        ss -> email "Envia e-mails"
        email -> cliente "Envia notificações via email"
    }
    
    views {
        systemContext ss "Diagram1" {
            include *
            autolayout lr   
        }

        styles {
            element "Element" {
                background #121212
                color #ffffff
                stroke #ffffff
                strokeWidth 2
                shape roundedbox
            }

            element "Person" {
                background #1565c0
                color #ffffff
                shape person
            }

            element "Software System" {
                background #2e7d32
                color #ffffff
            }

            element "External" {
                background #424242
                color #ffffff
                border dashed
            }

            relationship "Relationship" {
                color #ffffff
                thickness 2
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}
