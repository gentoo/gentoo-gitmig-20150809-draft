# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/usbprog/usbprog-0.2.0.ebuild,v 1.1 2010/09/10 23:33:42 robbat2 Exp $

EAPI=3
inherit eutils
DESCRIPTION="flashtool for the multi purpose programming adapter usbprog"

HOMEPAGE="http://www.embedded-projects.net/index.php?page_id=215"

SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X"
DEPEND="X? ( >=x11-libs/wxGTK-2.6.0 )
	>=dev-libs/libxml2-2.0.0
	net-misc/curl
	dev-libs/libusb
	sys-libs/readline"

RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable X gui) || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "einstall failed"
}
