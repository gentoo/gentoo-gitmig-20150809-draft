# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/olsrd/olsrd-0.6.2.ebuild,v 1.1 2011/10/07 17:01:39 jer Exp $

EAPI="4"

inherit eutils toolchain-funcs versionator

MY_PV=$(replace_version_separator 3 '-r')
DESCRIPTION="An implementation of the Optimized Link State Routing protocol"
HOMEPAGE="http://www.olsr.org/"
SRC_URI="http://www.olsr.org/releases/$(get_version_component_range 1-2)/${PN}-${MY_PV}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"
DEPEND="gtk? ( =x11-libs/gtk+-2* )"
RDEPEND=$DEPEND
S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.1-build_fix.patch"
cp -av gui/linux-gtk/Makefile{,.org}
	sed -i gui/linux-gtk/Makefile \
		-e 's|LFLAGS|LDFLAGS|g;' \
		-e 's|$(CC).*|$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)|g' \
		-e '/^LDFLAGS/s|=|+= -lm|g' \
		|| die
}

src_compile() {
	emake OS=linux CC="$(tc-getCC)" build_all
	use gtk && emake -C "${S}/gui/linux-gtk" CC="$(tc-getCC)"
}

src_install() {
	emake OS=linux DESTDIR="${D}" STRIP=true install_all
	use gtk && emake -C "${S}/gui/linux-gtk" DESTDIR="${D}" install

	doinitd "${FILESDIR}/olsrd"

	dodoc CHANGELOG \
		valgrind-howto.txt files/olsrd.conf.default.rfc \
		files/olsrd.conf.default.lq files/olsrd.conf.default.lq-fisheye \
		lib/arprefresh/README_ARPREFRESH \
		lib/bmf/README_BMF \
		lib/dot_draw/README_DOT_DRAW \
		lib/dyn_gw/README_DYN_GW \
		lib/dyn_gw_plain/README_DYN_GW_PLAIN \
		lib/httpinfo/README_HTTPINFO \
		lib/mini/README_MINI \
		lib/nameservice/README_NAMESERVICE \
		lib/pgraph/README_PGRAPH \
		lib/quagga/README_QUAGGA \
		lib/secure/README_SECURE \
		lib/txtinfo/README_TXTINFO \
		lib/watchdog/README_WATCHDOG
}
