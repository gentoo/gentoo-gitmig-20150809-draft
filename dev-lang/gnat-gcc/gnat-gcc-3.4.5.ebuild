# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gcc/gnat-gcc-3.4.5.ebuild,v 1.1 2006/01/17 20:12:10 george Exp $

inherit gnatbuild flag-o-matic

DESCRIPTION="GNAT Ada Compiler - gcc version"
HOMEPAGE="http://gcc.gnu.org/"
LICENSE="GMGPL"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-core-${PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-ada-${PV}.tar.bz2
	x86?   ( http://dev.gentoo.org/~george/src/gnatboot-${GNATBRANCH}-i686.tar.bz2 )
	amd64? ( http://dev.gentoo.org/~george/src/gnatboot-${GNATBRANCH}-amd64.tar.bz2 )"
# ${GNATBRANCH} is defined in gnatbuild.eclass and depends 
# only on $PV, so should be safe to use in DEPEND/SRC_URI

KEYWORDS="~amd64 ~x86"

src_unpack() {
	gnatbuild_src_unpack

	#fixup some hardwired flags
	cd ${S}/gcc/ada
	sed -i -e "s:CFLAGS = -O2:CFLAGS = ${CFLAGS}:"	\
		Makefile.adalib || die "patching Makefile.adalib failed"
}
