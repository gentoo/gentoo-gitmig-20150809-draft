# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wklej/wklej-0.2.0.ebuild,v 1.1 2010/06/29 16:47:03 ayoy Exp $

EAPI=2

inherit eutils

DESCRIPTION="A wklej.org submitter"
HOMEPAGE="http://wklej.org"
SRC_URI="http://wklej.org/m/apps/wklej-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="+vim"

DEPEND="${RDEPEND}"
RDEPEND="dev-lang/python
	vim? ( app-editors/vim[python] )"

src_install() {
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins "${WORKDIR}"/${PN}.vim || die "Failed to install vim plugin"
	fi

	dobin "${WORKDIR}"/${PN} || die "Failed to install ${PN} script"
	dodoc "${WORKDIR}"/README || die "Failed to install readme"
	dodoc "${WORKDIR}"/wklejrc || die "Failed to install wklejrc"
}

pkg_postinst() {
	elog "There are lots of changes in ${PV} version"
	elog "Check out the README file in /usr/share/doc/${P}/README.bz2"
	elog "Example of .wklejrc file /usr/share/doc/${P}/wklejrc.bz2"
}
