# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nhc98/nhc98-1.16.ebuild,v 1.2 2003/04/10 23:20:56 george Exp $

IUSE="readline"

TARBALL="nhc98src-${PV}.tar.gz"

DESCRIPTION="Haskell 98 compiler"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/${TARBALL}
	ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/patch-1.16-typesyn"
HOMEPAGE="http://www.cs.york.ac.uk/fp/nhc98/"

SLOT="0"
LICENSE="nhc98"
KEYWORDS="x86 ~sparc "

DEPEND="virtual/glibc
	readline? ( >=readline-4.1 )"

src_unpack() {
	# unpack the source
	unpack "${TARBALL}"
	# type synoym patch
	cd ${S}
	epatch ${DISTDIR}/patch-1.16-typesyn
#	cd ${P}
#	patch -p0 < ${FILESDIR}/patch-1.16-typesyn
}

src_compile() {

	./configure --buildwith=gcc \
		--prefix=/usr --installdir=/usr \
		-man -docs \
		--buildopts="${CFLAGS} --host=${CHOST}" || die "./configure failed"
	# the build does not seem to work all that
	# well with parallel make
	make || die
}

src_install () {
	# The install location is taken care of by the
	# configure script.
	make DESTDIR=${D} install || die

	#nhc's build system does not update hmakerc when using DESTDIR;
	#therefore, we do it manually here

	einfo "Adjusting... hmakerc"
	cd ${S}
	MACHINE=`script/harch`
        ${D}/usr/bin/hmake-config \
		${D}/usr/lib/hmake/${MACHINE}/hmakerc add /usr/bin/nhc98
	${D}/usr/bin/hmake-config \
		${D}/usr/lib/hmake/${MACHINE}/hmakerc add nhc98 ||\
          	einfo "(This error message is harmless)"
	${D}/usr/bin/hmake-config \
		${D}/usr/lib/hmake/${MACHINE}/hmakerc \
			default /usr/bin/nhc98
	# remove temporary build version of nhc98 from config
	${D}/usr/bin/hmake-config \
		${D}/usr/lib/hmake/${MACHINE}/hmakerc \
			delete ${S}/script/nhc98

	#need to adjust paths in hmakerc
	cd ${D}/usr/lib/hmake/${MACHINE}
	mv hmakerc hmakerc.orig
	sed -e "s:${S}/script/::" -e "s:${S}/include:/usr/include:" hmakerc.orig > hmakerc

	cd ${S}
	#install docs and man pages manually
	dodoc README INSTALL COPYRIGHT
	doman man/*

	cd docs
	dohtml -A hs -r *
	docinto html/bugs
	dodoc bugs/README
}
