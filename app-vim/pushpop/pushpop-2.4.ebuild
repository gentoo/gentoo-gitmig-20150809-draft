# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/pushpop/pushpop-2.4.ebuild,v 1.3 2004/07/24 02:54:20 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: pushd / popd from the vim commandline"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=129"
LICENSE="GPL-2"
KEYWORDS="~x86 sparc mips ~ppc"
IUSE=""

RDEPEND=">=app-vim/genutils-1.1
	>=app-vim/multvals-3.0
	>=app-vim/cmdalias-1.0"
