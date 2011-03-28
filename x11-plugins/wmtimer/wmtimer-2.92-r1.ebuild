# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtimer/wmtimer-2.92-r1.ebuild,v 1.3 2011/03/28 15:24:47 nirbheek Exp $

EAPI="1"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Dockable clock which can run in alarm, countdown timer or chronograph mode"
HOMEPAGE="http://www.darkops.net/wmtimer"
SRC_URI="http://www.darkops.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:\$(CFLAGS)::" -i Makefile
	sed -e "s:-g::g" -i Makefile
	sed -e "s:-O2:\$(CFLAGS) ${CFLAGS}:" -i Makefile
	sed -e "s:-o wmtimer:\$(LDFLAGS) -o wmtimer:" -i Makefile
	epatch "${FILESDIR}"/"${PN}"-counter-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" \
		LIBDIR="-L/usr/$(get_libdir)" || die "emake failed."
}

src_install() {
	dobin wmtimer
	dodoc ../{Changelog,CREDITS,README}
}
