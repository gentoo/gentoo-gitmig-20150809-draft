# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/dbext/dbext-12.00.ebuild,v 1.5 2011/12/11 15:33:38 armin76 Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: easy access to databases"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=356"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13339 -> ${P}.zip"
LICENSE="GPL-2"
KEYWORDS="amd64 ~mips ~ppc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="dbext"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
