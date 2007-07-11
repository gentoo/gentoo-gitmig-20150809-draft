# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/svncommand/svncommand-0.2.ebuild,v 1.3 2007/07/11 05:14:08 mr_bones_ Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: SVN (subversion) integration"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=922"
LICENSE="as-is"
KEYWORDS="x86 sparc ~hppa ~amd64 alpha ia64"
IUSE=""

# vimspell map conflict, bug #91965
RDEPEND="${RDEPEND}
	dev-util/subversion
	!app-vim/vimspell"

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=922"
