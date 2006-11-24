# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.96.ebuild,v 1.1 2006/11/24 15:40:11 tester Exp $

inherit eutils fdo-mime

MY_P=${P/_rc/RC}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://www.amsn-project.net"

# The tests are interactive
RESTRICT="test"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	>=dev-tcltk/tls-1.4.1
	media-libs/jpeg
	media-libs/libpng"

RDEPEND="${DEPEND}"

src_install() {
	make rpm-install INSTALL_PREFIX=${D}

	domenu amsn.desktop
	
	dodir /usr/share/icons/hicolor
	cp -r icons/*  ${D}/usr/share/icons/hicolor

	dodoc AGREEMENT TODO README FAQ CREDITS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	ewarn "You might have to remove ~/.amsn prior to running as user if amsn hangs on start-up."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
