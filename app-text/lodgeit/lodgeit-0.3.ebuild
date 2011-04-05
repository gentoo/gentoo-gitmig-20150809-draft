# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lodgeit/lodgeit-0.3.ebuild,v 1.3 2011/04/05 05:08:05 ulm Exp $

EAPI="2"

DESCRIPTION="Command-line interface to paste.pocoo.org"
HOMEPAGE="http://paste.pocoo.org/"
SRC_URI="http://dev.pocoo.org/hg/lodgeit-main/raw-file/tip/scripts/lodgeit.py
	-> ${P}.py
	vim? ( http://www.vim.org/scripts/download_script.php?src_id=8848
	-> ${P}.vim )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vim"

RESTRICT="test"

DEPEND=""
RDEPEND="dev-lang/python
	vim? ( || ( app-editors/vim[python] app-editors/gvim[python] ) )"

src_unpack() {
	:
}

src_install() {
	dobin "${DISTDIR}/${P}.py"
	dosym "/usr/bin/${P}.py" "/usr/bin/${PN}"

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		newins "${DISTDIR}/${P}.vim" "${PN}.vim"
	fi
}
