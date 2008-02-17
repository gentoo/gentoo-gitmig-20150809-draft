# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/olsrd/olsrd-0.5.0.ebuild,v 1.3 2008/02/17 12:15:28 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An implementation of the Optimized Link State Routing protocol"
HOMEPAGE="http://www.olsr.org/"
SRC_URI="http://www.olsr.org/releases/${PV%.*}/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-2* )"

src_compile() {
	emake OS=linux CC=$(tc-getCC) build_all || die "emake failed"

	if use gtk ; then
		cd "${S}/gui/linux-gtk"
		einfo "Building GUI ..."
		emake CC=$(tc-getCC) || die "emake failed"
	fi
}

src_install() {
	emake OS=linux DESTDIR="${D}" STRIP=true install_all || die "emake install_all failed"

	if use gtk; then
		cd "${S}/gui/linux-gtk"
		emake DESTDIR="${D}" install || die "emake install failed"
	fi

	doinitd "${FILESDIR}/olsrd"

	cd "${S}"
	dodoc CHANGELOG features.txt README README-Olsr-Switch.html \
		README-FreeBSD-libnet README-Link-Quality-Fish-Eye.txt \
		README-Link-Quality.html files/olsrd.conf.default.rfc \
		files/olsrd.conf.default.lq lib/dyn_gw/README_DYN_GW \
		lib/dot_draw/README_DOT_DRAW lib/httpinfo/README_HTTPINFO \
		lib/powerinfo/README_POWER
	newdoc lib/nameservice/README README-NAMESERVICE
	newdoc lib/secure/SOLSR-README README-SECURE
}
