return {
        cmd = { 'haskell-language-server-9.10.3', '--lsp' },
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        settings = {
                haskell = {
                        formattingProvider = 'ormolu',
                        cabalFormattingProvider = 'cabal-fmt',
                },
        },
}
