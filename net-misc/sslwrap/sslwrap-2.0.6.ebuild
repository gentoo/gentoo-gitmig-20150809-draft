# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslwrap/sslwrap-2.0.6.ebuild,v 1.6 2003/09/05 22:01:49 msterret Exp $

S=${WORKDIR}/${PN}${PV/.0./0}
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://quiltaholic.com/rickk/sslwrap/${PN}${PV/.0./0}.tar.gz
	mirror://gentoo/${PN}-gentoo.tar.bz2
	http://cvs.gentoo.org/~seemant/${PN}-gentoo.tar.bz2"
HOMEPAGE="http://quiltaholic.com/rickk/sslwrap/"

SLOT="0"
LICENSE="sslwrap"
KEYWORDS="x86 sparc"

DEPEND=">=dev-libs/openssl-0.9.6"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" \
		-e "s:/usr/local/ssl/include:/usr/include/openssl:" \
		Makefile.orig > Makefile

	cp ${WORKDIR}/${PN}-gentoo/*.c ${S}

	for f in *.h *.c ; do
		cp ${f} ${f}.orig
		sed -e "s:OPENSSL\":\"openssl\/:g" ${f}.orig > ${f}
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
