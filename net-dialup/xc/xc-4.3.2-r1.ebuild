# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xc/xc-4.3.2-r1.ebuild,v 1.1 2004/01/16 10:50:38 kumba Exp $

DESCRIPTION="unix dialout program"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips"
DEPEND="sys-libs/libtermcap-compat"
RDEPEND=""
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	# Adds 115200 bps support
	epatch ${FILESDIR}/${P}-add-115200.patch

	# Fixes the Makefile to use gentoo CFLAGS
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s:GCCOPT\t= -pipe -O2 -fno-strength-reduce -fomit-frame-pointer:GCCOPT\t= ${CFLAGS} -fno-strength-reduce:g" \
		${S}/Makefile.orig > ${S}/Makefile
}

src_compile() {
	make WARN="" all prefix=/usr mandir=/usr/share/man || die

}

src_install () {
	dodir /usr/bin /usr/share/man/man1 /usr/lib/xc

	make DESTDIR=${D} install || die

	insinto /usr/lib/xc
	doins phonelist xc.init dotfiles/.[a-z]*
}
