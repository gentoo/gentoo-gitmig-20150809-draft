# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nhc98/nhc98-1.16.ebuild,v 1.6 2003/09/11 01:08:23 msterret Exp $

inherit eutils

DESCRIPTION="Haskell 98 compiler"
HOMEPAGE="http://www.cs.york.ac.uk/fp/nhc98/"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/nhc98src-${PV}.tar.gz
	ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/patch-1.16-typesyn"

LICENSE="nhc98"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="readline"

DEPEND="virtual/glibc
	readline? ( >=readline-4.1 )"

src_unpack() {
	unpack nhc98src-${PV}.tar.gz
	# type synoym patch
	cd ${S}
	epatch ${DISTDIR}/patch-1.16-typesyn
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

src_install() {
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
}

pkg_postinst() {
	#nhc's build system does not update hmakerc when using DESTDIR;
	#therefore, we do it manually here

	einfo "Adjusting... hmakerc"
	MACHINE=`/usr/bin/harch`
	/usr/bin/hmake-config \
		/usr/lib/hmake/${MACHINE}/hmakerc add /usr/bin/nhc98
	/usr/bin/hmake-config \
		/usr/lib/hmake/${MACHINE}/hmakerc add nhc98 ||\
		einfo "(This error message is harmless)"
	/usr/bin/hmake-config \
		/usr/lib/hmake/${MACHINE}/hmakerc \
			default /usr/bin/nhc98
	# remove temporary build version of nhc98 from config
	/usr/bin/hmake-config \
		/usr/lib/hmake/${MACHINE}/hmakerc \
			delete ${S}/script/nhc98
}
