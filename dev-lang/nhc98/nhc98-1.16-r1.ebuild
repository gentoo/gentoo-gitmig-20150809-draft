# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nhc98/nhc98-1.16-r1.ebuild,v 1.1 2003/04/24 16:04:21 kosmikus Exp $

IUSE="readline"

TARBALL="nhc98src-${PV}.tar.gz"

DESCRIPTION="Haskell 98 compiler"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/${TARBALL}
	ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/patch-1.16-typesyn"
HOMEPAGE="http://www.cs.york.ac.uk/fp/nhc98/"

SLOT="0"
LICENSE="nhc98"
KEYWORDS="~x86 ~sparc "

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

	#install docs and man pages manually
	dodoc README INSTALL COPYRIGHT
	doman man/*

	cd docs
	dohtml -A hs -r *
	docinto html/bugs
	dodoc bugs/README

	# Manually remove everything hmake-specific.
	# hmake has its own package and thus should not be
	# overwritten by nhc98. It might be considered
	# to make nhc98 PDEPEND on hmake, though ...
	rm ${D}/usr/bin/hmake*
	rm ${D}/usr/bin/{harch,hi}
	rm -rf ${D}/usr/lib/hmake
        rm ${D}/usr/share/man/man1/hmake*
}

pkg_postinst () {
	# info about new package structure
	einfo "NOTICE: hmake is no longer a part of this package,"
	einfo "but separately available as dev-haskell/hmake."
}
