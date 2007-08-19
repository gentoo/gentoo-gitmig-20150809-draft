# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/koctave/koctave-0.65-r1.ebuild,v 1.7 2007/08/19 00:47:25 markusle Exp $

inherit kde

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
	|| ( kde-base/konsole kde-base/kdebase )"

S=${WORKDIR}/${PN}3-${PV}

need-kde 3.4

src_unpack() {
	kde_src_unpack
	use arts || epatch ${FILESDIR}/${P}-arts-configure.patch
}

src_install() {
	kde_src_install
	dohtml ${WORKDIR}/docs/*
}
