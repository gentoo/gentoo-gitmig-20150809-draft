# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wklej/wklej-0.1.6.ebuild,v 1.4 2009/05/28 15:42:03 fauli Exp $

EAPI=2

inherit eutils

DESCRIPTION="A wklej.org submitter"
HOMEPAGE="http://wklej.org"
SRC_URI="http://wklej.org/m/apps/wklej-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE="+vim"

DEPEND="${RDEPEND}"
RDEPEND="dev-lang/python
	vim? ( app-editors/vim[python] )"

src_install() {
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins "${WORKDIR}"/${PN}.vim
	fi

	dobin "${WORKDIR}"/${PN}
	dodoc "${FILESDIR}"/wklejrc.txt

	elog "A new feature was added since version ${PV}"
	elog "Now you can use ~/.wklejrc which allows you to pastebin as"
	elog "an authorized user."
	elog "Go to http://wklej.org/salt to get your SALT_KEY."
}
