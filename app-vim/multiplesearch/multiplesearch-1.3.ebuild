# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/multiplesearch/multiplesearch-1.3.ebuild,v 1.4 2010/11/14 17:13:15 armin76 Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: allows multiple highlighted searches"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=479"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=9276 -> ${P}.zip"
LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ~mips ~ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="MultipleSearch"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
