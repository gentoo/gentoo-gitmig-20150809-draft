# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/dbext/dbext-12.00.ebuild,v 1.4 2010/11/14 17:09:00 armin76 Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: easy access to databases"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=356"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13339 -> ${P}.zip"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~mips ~ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="dbext"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
