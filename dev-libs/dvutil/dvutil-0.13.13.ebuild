# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-0.13.13.ebuild,v 1.8 2004/11/17 04:46:39 mr_bones_ Exp $

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
	local PATCHS="${FILESDIR}/0.13.13-gentoo-doc_distdir.patch"

	epatch ${PATCHS} || die "error applying patch(s) [${PATCHS}]"
	make DESTDIR=${D} install || die "error in make install"
}
