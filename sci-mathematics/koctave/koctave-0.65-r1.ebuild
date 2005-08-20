# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/koctave/koctave-0.65-r1.ebuild,v 1.3 2005/08/20 16:50:19 ribosome Exp $

inherit kde

DESCRIPTION="A KDE GUI for Octave numerical computing system"
HOMEPAGE="http://athlone.ath.cx/~matti/kde/koctave/"
SRC_URI="http://athlone.ath.cx/~matti/kde/koctave/${PN}3-${PV}.tar.bz2
	mirror://gentoo/koctave-docs-20050605.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ~sparc"
IUSE="arts"


DEPEND="virtual/libc
	sci-mathematics/octave
	kde-base/kdelibs"

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
