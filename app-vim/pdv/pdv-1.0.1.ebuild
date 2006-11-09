# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/pdv/pdv-1.0.1.ebuild,v 1.1 2006/11/09 06:00:21 pioto Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: PDV (phpDocumentor for Vim)"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1355"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT="To use this plugin, you should map the PhpDoc() function
to something. For example, add the following to your ~/.vimrc:

imap <C-o> ^[:set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i

For more info, see:
${HOMEPAGE}"
