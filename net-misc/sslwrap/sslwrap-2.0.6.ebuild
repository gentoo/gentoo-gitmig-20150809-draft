# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslwrap/sslwrap-2.0.6.ebuild,v 1.2 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${PN}${PV/.0./0}
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://quiltaholic.com/rickk/sslwrap/${PN}${PV/.0./0}.tar.gz"
HOMEPAGE="http://quiltaholic.com/rickk/sslwrap/"
KEYWORDS="x86 sparc sparc64"
LICENSE="sslwrap"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/openssl-0.9.6"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" \
			-e "s:/usr/local/ssl/include:/usr/include/openssl:" Makefile.orig > Makefile
	cp ${FILESDIR}/*.c ${S}
	for f in *.h *.c ; do
		cp ${f} ${f}.orig
		sed -e "s/OPENSSL\"/\"openssl\//g" ${f}.orig > ${f}
	done
}

src_compile() {													 
	emake || die
}

src_install() {															 
	cd ${S}
	into /usr
	dosbin sslwrap
	dodoc README
	dohtml -r ./
}
