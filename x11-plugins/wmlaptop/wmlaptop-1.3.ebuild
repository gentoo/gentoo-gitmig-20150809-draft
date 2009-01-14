# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlaptop/wmlaptop-1.3.ebuild,v 1.7 2009/01/14 15:54:35 s4t4n Exp $

IUSE=""

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Dockapp for laptop users"
SRC_URI="http://www.dockapps.org/download.php/id/474/${P}.tar.bz2"
HOMEPAGE="http://www.dockapps.org/file.php/id/227"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	>=sys-apps/sed-4.1.5-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

src_unpack() {
	unpack ${A}

	#Prevent automatic stripping of binaries. Closes bug #252109
	sed -i 's/install -c -o 0 -g 0 -s -m/install -c -o 0 -g 0 -m/' "${S}/src/Makefile"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall" || die "Compilation failed"
}

src_install() {
	dodir /usr/bin
	einstall INSTALLDIR="${D}/usr/bin" || die "Installation failed"

	dodoc AUTHORS README README.IT THANKS

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
}
