# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kalamaris/kalamaris-0.7.1.ebuild,v 1.2 2004/07/22 23:44:50 dholm Exp $

inherit kde
need-kde 3

DESCRIPTION="The KDE Computer Algebra System"
HOMEPAGE="http://developer.kde.org/~larrosa/kalamaris.html"
SRC_URI="http://developer.kde.org/~larrosa/bin/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"

DEPEND="${DEPEND}
	dev-libs/gmp"

S="${WORKDIR}/${PN}"

src_install() {
	kde_src_install
	insinto /usr/share/${PN}/examples
	doins kalamaris/examples/*
	insinto /usr/share/${PN}/examples2
	doins kalamaris/examples2/*
}
