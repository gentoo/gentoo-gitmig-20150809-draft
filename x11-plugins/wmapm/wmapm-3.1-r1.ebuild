# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmapm/wmapm-3.1-r1.ebuild,v 1.16 2010/10/11 09:17:28 s4t4n Exp $

DESCRIPTION="WindowMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://dockapps.org/download.php/id/25/${P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/18"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/${P}/${PN}

src_unpack()
{
	unpack ${A}
	cd "${S}"

	#Respect LDFLAGS, see bug #334747
	sed -i 's/ -o wmapm/ ${LDFLAGS} -o wmapm/' "Makefile"
}

src_compile() {
	emake COPTS="${CFLAGS}" || die "make failed"
}

src_install() {
	dobin wmapm || die "dobin failed."
	doman wmapm.1
	dodoc ../{BUGS,CHANGES,HINTS,README,TODO}
}
