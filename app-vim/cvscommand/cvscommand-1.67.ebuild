# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvscommand/cvscommand-1.67.ebuild,v 1.2 2005/01/21 22:38:16 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
LICENSE="public-domain"
KEYWORDS="~alpha ~ia64 ~ppc ~sparc ~x86 ~amd64"
IUSE=""

VIM_PLUGIN_HELPFILES="cvscommand-contents"
# conflict, bug 62677
RDEPEND="${RDEPEND}
	dev-util/cvs
	!app-vim/calendar"
