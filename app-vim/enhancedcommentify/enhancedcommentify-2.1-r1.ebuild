# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/enhancedcommentify/enhancedcommentify-2.1-r1.ebuild,v 1.8 2004/12/21 16:16:34 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: enhanced comment creation"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=23"
SRC_URI="mirror://gentoo/${P}-r1.tar.bz2"

LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 mips ~ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="EnhancedCommentify"

# bug #74897
RDEPEND="!app-vim/ctx"
