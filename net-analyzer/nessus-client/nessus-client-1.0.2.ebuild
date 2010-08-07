# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-client/nessus-client-1.0.2.ebuild,v 1.6 2010/08/07 15:51:25 jer Exp $

inherit eutils

MY_PN="NessusClient"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A client for the Nessus vulnerability scanner"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	mirror://gentoo/nessus-client.png.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

DEPEND="!net-analyzer/nessus-core
	dev-libs/openssl
	>=x11-libs/gtk+-2.8.8"
RDEPEND="doc? ( app-text/htmldoc )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES README_SSL VERSION

	doicon "${WORKDIR}"/${PN}.png
	make_desktop_entry NessusClient "Nessus Client" nessus-client "Application;Network;"
}

pkg_postinst() {
	if ! use doc ; then
		elog "If you do not have documentation installed, nessus-client"
		elog "will complain. To install documentation, please emerge with"
		elog "the doc useflag set. Beware that it will emerge app-text/htmldoc,"
		elog "a big package."
	fi
}
