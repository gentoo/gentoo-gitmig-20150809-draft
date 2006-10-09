# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-client/nessus-client-1.0.0_rc5.ebuild,v 1.1 2006/10/09 18:18:39 jokey Exp $

inherit eutils

MY_P="NessusClient-${PV/_rc/.RC}"
DESCRIPTION="A client for the Nessus vulnerability scanner"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	mirror://gentoo/nessus-client.png.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="!net-analyzer/nessus-core
	dev-libs/openssl
	media-libs/glitz
	>=x11-libs/gtk+-2.8.8"

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
