# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvscommand/cvscommand-1.63.ebuild,v 1.10 2005/01/21 22:38:16 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
LICENSE="public-domain"
KEYWORDS="x86 alpha sparc ia64 ~ppc"
IUSE=""

RDEPEND="${RDEPEND} dev-util/cvs"
