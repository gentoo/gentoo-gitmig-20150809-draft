# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.5.12.ebuild,v 1.7 2003/02/11 13:00:40 seemant Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Gesture/Handwriting recognition engine for X"
HOMEPAGE="http://www.east.isi.edu/projects/DSN/xstroke/"
SRC_URI="ftp://ftp.handhelds.org/pub/projects/${PN}/release-0.5/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	http://cvs.gentoo.org/~seemant/${P}-gentoo.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=x11-base/xfree-4.1.0"

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	epatch ${WORKDIR}/${P}-gentoo.diff
}

src_compile() {
	make DESTDIR=${D} || die
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die
}

