workspace "BrinqueFeliz" "Diagrama de Contexto" {

    !identifiers hierarchical

    model {
        admin = person "Administrador"
        cliente = person "Cliente"
        funcionario = person "Funcionário"

        sso = softwareSystem "Sistema de Autenticação SSO" {
            tags "External"
        }

        email = softwareSystem "Sistema de E-mail" {
            tags "External"
        }

        ss = softwareSystem "BrinqueFeliz"

        admin -> ss "Gerencia usuários e permissões"
        cliente -> ss "Realiza operações básicas"
        funcionario -> ss "Gerencia pedidos e atende clientes"

        ss -> sso "Autentica usuário"
        ss -> email "Envia e-mails"
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
