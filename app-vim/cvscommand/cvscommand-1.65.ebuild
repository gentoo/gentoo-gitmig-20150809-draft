# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvscommand/cvscommand-1.65.ebuild,v 1.8 2005/01/01 16:48:37 eradicator Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
LICENSE="public-domain"
KEYWORDS="alpha ia64 ~ppc sparc x86 ~amd64"
IUSE=""

VIM_PLUGIN_HELPFILES="cvcsommand-contents"
# conflict, bug 62677
RDEPEND="!app-vim/calendar"
