# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-3.0.1-r1.ebuild,v 1.1 2008/08/28 20:06:34 ikelos Exp $

inherit toolchain-funcs autotools eutils

SAMDUMP_VER="2.0"

DESCRIPTION="A time-memory-trade-off-cracker"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/samdump2-${SAMDUMP_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip
		>=dev-util/pkgconfig-0.22
		dev-libs/openssl
		net-libs/netwib
		>=x11-libs/qt-4"
RDEPEND="dev-libs/openssl
		 net-libs/netwib
		 >=x11-libs/qt-4
		 app-crypt/ophcrack-tables"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
	epatch "${FILESDIR}/${P}-makefile.patch"
	cd "${WORKDIR}"
	epatch "${FILESDIR}/samdump2-${SAMDUMP_VER}.patch"
}

src_compile() {
	# Make samdump2
	einfo "Compiling samdump2"
	cd "${WORKDIR}/samdump2-${SAMDUMP_VER}"
	MAKEOPTS="-j1" emake || die "Failed to make samdump"

	# Make the program
	einfo "Compiling ophcrack"
	cd "${S}"
	econf
	emake || die "Failed to make ophcrack"

	# Don't try to install the prebuilt binaries,
	# they'll cause an access violation
	rm -fr "${S}/linux_tools"
}

src_install() {
	make install DESTDIR="${D}"

	cd "${WORKDIR}/samdump2-${SAMDUMP_VER}"
	make install DESTDIR="${D}" PREFIX=/usr/

	cd "${S}"
	newicon src/gui/pixmaps/os.xpm ophcrack.xpm
	make_desktop_entry "${PN}" OphCrack ophcrack
}
