workspace "BrinqueFeliz" "Diagrama de Contexto e Containers" {

    !identifiers hierarchical

    model {
    
        // Pessoas
        admin = person "Administrador" "Gerencia o catálogo, usuários e permissões do sistema."
        cliente = person "Cliente" "Usuário que navega no catálogo e realiza compras."
        funcionario = person "Funcionário" "Colaborador que processa pedidos e realiza o atendimento."
        
        // Sistemas externos
        sso = softwareSystem "Sistema de Autenticação SSO" {
            description "Autentica usuários via SSO"
            tags "External"
        }
        
        email = softwareSystem "Sistema de E-mail" {
            description "Envia confirmação de cadastro e compras."
            tags "External"
        }
        
        // Sistema principal + containers
        ss = softwareSystem "BrinqueFeliz" {
            description "Sistema Principal da Loja BrinqueFeliz."

            web = container "Web Application" {
                description "Interface web utilizada pelos usuários."
                technology "HTML, CSS, JavaScript"
            }

            api = container "Backend API" {
                description "Responsável pela lógica de negócio e integrações."
                technology "Java / Spring Boot"
            }

            db = container "Database" {
                description "Armazena dados de usuários, pedidos e produtos."
                technology "PostgreSQL"
                tags "Database"
            }
        }
        
        // Contexto
        admin -> ss "Gerencia usuários e permissões"
        cliente -> ss "Realiza operações básicas"
        funcionario -> ss "Gerencia pedidos e atende clientes"
        
        email -> cliente "Entrega notificações"
        
        // Containers
        admin -> ss.web "Usa"
        cliente -> ss.web "Usa"
        funcionario -> ss.web "Usa"
        
        ss.web -> ss.api "Consome API"
        ss.api -> ss.db "Lê e grava dados"
        
        ss.api -> sso "Autentica usuários"
        ss.api -> email "Envia notificações por e-mail"
    }
    
    views {
        systemContext ss "Diagram1" {
            include *
            autolayout lr   
        }
        
        container ss "Diagram2" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                background #121212
                color #ffffff
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

            element "Container" {
                background #1b5e20
                color #ffffff
            }

            element "Database" {
                shape cylinder
                background #1b5e20
                color #ffffff
            }

            element "External" {
                background #424242
                color #ffffff
            }

        }
    }

    configuration {
        scope softwaresystem
    }

}
