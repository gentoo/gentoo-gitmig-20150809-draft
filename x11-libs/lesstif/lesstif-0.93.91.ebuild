# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="An OSF/Motif(R) clone"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="2.1"

PROVIDE="virtual/motif"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {
	unpack ${A}

	cd ${S}/scripts/autoconf
	sed -e "/^aclocaldir =/ a DESTDIR = ${D}" \
		Makefile.in > Makefile.in.hacked
	mv Makefile.in.hacked Makefile.in || die
}

src_compile() {
	econf \
		--enable-static \
		--enable-build-21 \
		--enable-production \
		--with-x || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"
}
