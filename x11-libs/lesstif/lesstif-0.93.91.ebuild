# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit libtool

DESCRIPTION="An OSF/Motif(R) clone"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"

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
	elibtoolize

	econf \
	  --prefix=/usr/LessTif \
	  --mandir=/usr/LessTif/man \
	  --enable-build-12 \
	  --disable-build-20 \
	  --disable-build-21 \
	  --enable-static \
	  --enable-shared \
	  --enable-production \
	  --enable-verbose=no \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"
	prepman "/usr/LessTif"

	dodir /usr/X11R6/lib
	for lib in libMrm.so.1 libMrm.so.1.0.2 \
	           libUil.so.1 libUil.so.1.0.2 \
	           libXm.so.1  libXm.so.1.0.2
	do
		dosym "/usr/LessTif/lib/${lib}"\
		      "/usr/X11R6/lib/${lib}" || die "symlinking ${lib}"
	done

	dodir "/usr/share/doc"
	dosym "/usr/LessTif/LessTif"\
	      "/usr/share/doc/${PF}" || die "linking docs"
}
