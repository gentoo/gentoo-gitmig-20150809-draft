# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.3-r4.ebuild,v 1.13 2003/06/21 22:06:05 drobbins Exp $

inherit eutils

# Official patches
PLEVEL="x001 x002"

S="${WORKDIR}/${P}"
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${P}.tar.gz
	 ftp://gatekeeper.dec.com/pub/GNU/readline/${P}.tar.gz
	 ${PLEVEL//x/ftp://ftp.gnu.org/gnu/${PN}/${PN}-${PV}-patches/${PN}${PV/\.}-}"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc ~alpha hppa arm mips"

# We must be sertain that we have a bash that is linked
# to its internal readline, else we may get problems.
DEPEND=">=app-shells/bash-2.05b-r2
	>=sys-libs/ncurses-5.2-r2"

src_unpack() {
	
	unpack ${P}.tar.gz

	cd ${S}
	for x in ${PLEVEL//x}
	do
		epatch ${DISTDIR}/${PN}${PV/\.}-${x}
	done

	# Fix segfaults in Python when using latin-1 chars in interactive mode
	# (bug #11762).
	epatch ${FILESDIR}/readline4.3-mbutil.patch
}

src_compile() {

	econf --with-curses || die
	
	emake || die
	cd shlib
	emake || die
}


src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die
	cd ${S}/shlib
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die

	cd ${S}

	dodir /lib
	mv ${D}/usr/lib/*.so* ${D}/lib
	rm -f ${D}/lib/*.old
	# bug #4411
	gen_usr_ldscript libreadline.so
	gen_usr_ldscript libhistory.so
	# end bug #4411
	dosym libhistory.so.${PV/a/} /lib/libhistory.so
	dosym libreadline.so.${PV/a/} /lib/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.${PV/a/} /lib/libhistory.so.4
	dosym libreadline.so.${PV/a/} /lib/libreadline.so.4
	chmod 755 ${D}/lib/*.${PV/a/}

	dodoc CHANGELOG CHANGES COPYING MANIFEST README USAGE
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc
}

