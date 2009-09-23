# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/koctave/koctave-0.65-r1.ebuild,v 1.10 2009/09/23 20:10:55 patrick Exp $

EAPI="1"

inherit kde

DESCRIPTION="A KDE GUI for Octave numerical computing system"
HOMEPAGE="http://athlone.ath.cx/~matti/kde/koctave/"
SRC_URI="http://athlone.ath.cx/~matti/kde/koctave/${PN}3-${PV}.tar.bz2
	mirror://gentoo/koctave-docs-20050605.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="arts"

DEPEND="sci-mathematics/octave
	|| ( kde-base/konsole:3.5 kde-base/kdebase:3.5 )"

S="${WORKDIR}"/${PN}3-${PV}

need-kde 3.5

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-desktop-entry-fix.patch
	use arts || epatch "${FILESDIR}"/${P}-arts-configure.patch
}

src_install() {
	kde_src_install
	dohtml "${WORKDIR}"/docs/*
}
