# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/koctave/koctave-0.65-r1.ebuild,v 1.9 2008/10/12 11:54:21 markusle Exp $

inherit kde

EAPI="1"

DESCRIPTION="A KDE GUI for Octave numerical computing system"
HOMEPAGE="http://athlone.ath.cx/~matti/kde/koctave/"
SRC_URI="http://athlone.ath.cx/~matti/kde/koctave/${PN}3-${PV}.tar.bz2
	mirror://gentoo/koctave-docs-20050605.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="arts"

DEPEND="virtual/libc
	sci-mathematics/octave
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
