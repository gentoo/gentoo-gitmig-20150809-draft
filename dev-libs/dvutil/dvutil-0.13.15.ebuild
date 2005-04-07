# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-0.13.15.ebuild,v 1.1 2005/04/07 02:54:46 pvdabeel Exp $

inherit eutils

DESCRIPTION="dvutil provides some general C++ utility classes for files, directories, dates, property lists, reference counted pointers, number conversion etc. "
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/download/dvutil-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/dvutil-${PV}"

src_install() {
	make DESTDIR=${D} install || die "error in make install"
}
