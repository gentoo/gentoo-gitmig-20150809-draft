# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus/ksimus-0.3.6-r1.ebuild,v 1.4 2003/08/25 10:19:54 phosphan Exp $

inherit kde-base

MY_PATCH="ksimus-patch-0.3.6-2"
DESCRIPTION="KSimus is a KDE tool for simulation, automatization and visualization of technical processes."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-3-${PV}.tar.gz
		http://ksimus.berlios.de/download/${MY_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc" # stop complaining, we need kde - see below

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ../${MY_PATCH} || die "patch failed"
	make -f Makefile.dist # configure.in.in was patched
}

