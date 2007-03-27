# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-client/nessus-client-1.0.2.ebuild,v 1.2 2007/03/27 22:32:46 jokey Exp $

inherit eutils

MY_PN="NessusClient"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A client for the Nessus vulnerability scanner"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	mirror://gentoo/nessus-client.png.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="!net-analyzer/nessus-core
	dev-libs/openssl
	media-libs/glitz
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
	make_desktop_entry NessusClient "Nessus Client" /usr/share/pixmaps/nessus-client.png "Application;Network;"
}

pkg_postinst() {
	if ! use doc ; then
	    elog "To have docs available and the Client not complaining about not finding them you need"
	    elog "to set the doc useflag. Though it will add htmldoc as dependency then, a not that small package"
	fi
}