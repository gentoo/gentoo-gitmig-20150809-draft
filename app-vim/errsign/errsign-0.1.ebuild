# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/errsign/errsign-0.1.ebuild,v 1.2 2004/11/24 17:43:01 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: display marks on lines with errors"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1027"

LICENSE="as-is"
KEYWORDS="sparc mips x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
'To use this plugin, simply type \\\\es in normal mode and any lines which
have been marked as errors (for example, via :make) will be indicated with
a >> mark on the left of the window.'
