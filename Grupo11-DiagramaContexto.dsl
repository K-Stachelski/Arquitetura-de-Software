workspace "BrinqueFeliz" "Diagrama de Contexto e Containers" {

    !identifiers hierarchical

    model {
        // Pessoas
        admin = person "Administrador" "Gerencia catálogo, usuários e permissões."
        cliente = person "Cliente" "Navega no catálogo e realiza compras."
        funcionario = person "Funcionário" "Processa pedidos e atende clientes."
        
        // Sistemas externos
        sso = softwareSystem "Sistema de Autenticação SSO" {
            description "Responsável pela autenticação segura de usuários."
            tags "External"
        }
        
        email = softwareSystem "Sistema de E-mail" {
            description "Responsável pelo envio de notificações e confirmações."
            tags "External"
        }
        // Sistema principal e Containers
        ss = softwareSystem "BrinqueFeliz" {
            description "Sistema de vendas e gerenciamento da loja de brinquedos."

            webAdmin = container "Website Loja" {
                description "Interface web para administração e funcionarios."
                technology "HTML, CSS, JavaScript"
            }

            webCliente = container "Website Cliente" {
                description "Interface web para clientes navegarem e realizarem compras."
                technology "HTML, CSS, JavaScript"
            }

            mobile = container "App Mobile" {
                description "Aplicativo para Android e IOS, acessado pelo cliente para realização de compras."
                technology "React Native, TypeScript/JS"
            }

            backend = container "Backend" {
                description "Processa regras de negócio, autenticação e integrações."
                technology "Java / Spring Boot"
            }

            bd = container "Banco de Dados" {
                description "Armazena dados de usuários, pedidos, produtos e pagamentos."
                technology "PostgreSQL"
                tags "Database"
            }
        }
        // Contexto
        admin -> ss "Administra usuários, permissões e catálogo"
        funcionario -> ss "Gerencia pedidos e realiza atendimento"
        cliente -> ss "Consulta produtos e realiza compras"

        email -> cliente "Entrega notificações e confirmações de compra"
        
        // Containers
        admin -> ss.webAdmin "Gerencia sistema via interface administrativa"
        funcionario -> ss.webAdmin "Opera pedidos e atendimento via painel"
        
        cliente -> ss.webCliente "Navega no catálogo e realiza compras via navegador"
        cliente -> ss.mobile "Realiza compras e acompanha pedidos via aplicativo"
        
        // Relacionamentos
        ss.webAdmin -> ss.backend "Envia requisições de gerenciamento"
        ss.webCliente -> ss.backend "Envia requisições de navegação e compra"
        ss.mobile -> ss.backend "Consome serviços de catálogo e pedidos"
        
        ss.backend -> ss.bd "Consulta dados de necessarios"
        ss.backend -> sso "Valida identidade dos usuários"
        ss.backend -> email "Envia notificações de cadastro, pedidos e pagamentos"
    }
    
    views {
        systemContext ss "Contexto" {
            include *
            autolayout lr
        }
        
        container ss "Containers" {
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
