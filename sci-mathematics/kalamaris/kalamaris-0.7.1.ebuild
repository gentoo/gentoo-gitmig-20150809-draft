# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/kalamaris/kalamaris-0.7.1.ebuild,v 1.3 2005/08/22 15:49:09 phosphan Exp $

inherit kde

DESCRIPTION="The KDE Computer Algebra System"
HOMEPAGE="http://developer.kde.org/~larrosa/kalamaris.html"
SRC_URI="http://developer.kde.org/~larrosa/bin/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~ppc ~sparc x86"

DEPEND="dev-libs/gmp"

need-kde 3

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir fakebin
	for prog in mcopidl artsc-config; do
		echo '#!/bin/sh' > fakebin/${prog}
		chmod +x fakebin/${prog}
	done
}

src_compile() {
	PATH="${PATH}:${KDEDIR}/bin:fakebin" econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	kde_src_install
	insinto /usr/share/${PN}/examples
	doins kalamaris/examples/*
	insinto /usr/share/${PN}/examples2
	doins kalamaris/examples2/*
}
