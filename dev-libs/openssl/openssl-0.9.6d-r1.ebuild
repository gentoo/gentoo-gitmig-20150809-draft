# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.6d-r1.ebuild,v 1.4 2002/07/17 05:07:21 jtegart Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/${P}.tar.gz"
HOMEPAGE="http://www.openssl.org/"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=sys-devel/perl-5"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A} ; cd ${S}
	cp Configure Configure.orig
	sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" Configure.orig > Configure
	if [ ${ARCH} = "sparc64" ] || [ ${ARCH} = "sparc" ]; then
		cp Makefile.org Makefile.orig
		sed -e "s/\${SHARED_LDFLAGS}//" Makefile.orig > Makefile.org
	fi
}

src_compile() {
	./config --prefix=/usr --openssldir=/usr/lib/ssl shared threads || die
	# i think parallel make has problems
	# as of 0.9.6d-r1, emake seems to work for me (drobbins, 15 Jul 2002)
	# people should test emake and see if we should re-enable it.
	make all || die
}

src_install() {
	make INSTALL_PREFIX=${D} MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ LICENSE NEWS README
	dodoc doc/*.txt
	dohtml doc/*
	insinto /usr/share/emacs/site-lisp
	doins doc/c-indentation.el

	# The man pages rand.3 and passwd.1 conflict with other packages
	# Rename them to ssl-* and also make a symlink from openssl-* to ssl-*
	cd ${D}/usr/share/man/man1
	mv passwd.1 ssl-passwd.1
	ln -sf ssl-passwd.1 openssl-passwd.1
	cd ${D}/usr/share/man/man3
	mv rand.3 ssl-rand.3
	ln -sf ssl-rand.3 openssl-rand.3
}
