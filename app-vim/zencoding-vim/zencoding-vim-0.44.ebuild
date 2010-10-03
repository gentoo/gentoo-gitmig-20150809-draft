# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zencoding-vim/zencoding-vim-0.44.ebuild,v 1.1 2010/10/03 18:50:57 spatz Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

MY_PN="${PN%-*}"

DESCRIPTION="vim plugin: HTML and CSS hi-speed coding"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2981 http://mattn.github.com/zencoding-vim/"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13765 -> ${P}.vim"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	mkdir "${S}/plugin" || die
	cp "${DISTDIR}/${P}.vim" "${S}/plugin/${MY_PN}.vim" || die
}
