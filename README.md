# SixxTerm

<div align="center">

![version](https://img.shields.io/badge/versão-1.0.0-5ac8fa?style=flat-square) ![platform](https://img.shields.io/badge/plataforma-Termux-4caf50?style=flat-square) ![shell](https://img.shields.io/badge/shell-zsh-bf5af2?style=flat-square) ![license](https://img.shields.io/badge/licença-MIT-ffbd2e?style=flat-square)

**Terminal do Termux com visual estilo macOS**

🔴 🟡 🟢

</div>

---

## Instalação

```bash
git clone https://github.com/Ytsixx/SixxTerm ~/SixxTerm
bash ~/SixxTerm/install.sh
```

> Reinicie o Termux após a instalação.

---

## O que é instalado

| | Funcionalidade | Descrição |
|---|---|---|
| ◆ | **SF Mono** | Fonte original do macOS |
| ◆ | **Zsh + Plugins** | Autocomplete, syntax highlighting e histórico |
| ◆ | **Banner Dinâmico** | RAM, DISK, IP e caminho atual |
| ◆ | **JSON Formatter** | Formata JSON/XML/CSV automaticamente no terminal |
| ◆ | **logo-ls** | `ls` com ícones e cores |
| ◆ | **Aliases** | Git, pnpm, npm, rede e muito mais |

---

## Comandos

```bash
sixxterm help      # Ver todos os comandos e aliases
sixxterm update    # Atualizar para a versão mais recente
sixxterm version   # Ver versão instalada
sixxterm info      # Informações do sistema
sixxterm restore   # Restaurar Termux ao padrão
```

---

## Aliases

| Categoria | Exemplos |
|---|---|
| **Git** | `gs`, `ga`, `gc "msg"`, `gp`, `gpl`, `gl`, `gcb`, `gst` |
| **pnpm** | `pi`, `pa`, `pad`, `pd`, `pb`, `px`, `pu` |
| **npm** | `ni`, `nid`, `nd`, `nb`, `nx`, `ninit` |
| **Ficheiros** | `mkcd`, `sizes`, `untar`, `zipp`, `count`, `newest` |
| **Rede** | `myip`, `pingg`, `speedtest`, `ports`, `headers` |
| **Termux** | `tb`, `tw`, `tc`, `topen`, `tshare`, `tvib` |
| **Sistema** | `mem`, `cpu`, `psa`, `uptime`, `reload` |
| **Python** | `py`, `pip`, `pyv`, `pys`, `pyc` |
| **SSH** | `keygen`, `pubkey`, `sshconfig` |

---

## JSON Formatter

```bash
curl "https://api.exemplo.com/dados"  # automático
cat ficheiro.json | fmt               # pipe manual
cjson "https://api.exemplo.com"       # forçar JSON
jget '.url' '{"url":"https://..."}'   # extrair campo
```

---

## Restaurar

```bash
sixxterm restore
# ou
bash ~/restore.sh
```

---

<div align="center">

by [@ytsixx](https://github.com/Ytsixx)

</div>
