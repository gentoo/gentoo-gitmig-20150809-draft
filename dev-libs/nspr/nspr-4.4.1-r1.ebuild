# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nspr/nspr-4.4.1-r1.ebuild,v 1.1 2004/11/15 21:16:29 liquidx Exp $

inherit eutils

DESCRIPTION="Netscape Portable Runtime"
HOMEPAGE="http://www.mozilla.org/projects/nspr/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v${PV}/src/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	mkdir ${S}/build
	mkdir ${S}/inst
	if [ "${ARCH}" = "amd64" ]
	then
		cd ${S}; epatch ${FILESDIR}/${PN}-4.3-amd64.patch
	elif [ "${ARCH}" = "hppa" ]
	then
		cd ${S}
		epatch ${FILESDIR}/${PN}-${PV}-hppa.patch
	fi
}
src_compile() {
	cd ${S}/build
	../mozilla/nsprpub/configure \
		--host=${CHOST} \
		--prefix=${S}/inst \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	# Their build system is royally fucked, as usual
	cd ${S}/build
	make install
	dodir /usr
	cp -rfL dist/* ${D}/usr
	rm -rf ${D}/usr/bin/lib*.so

	# cope with libraries being in /usr/lib/nspr
	dodir /etc/env.d
	echo 'LDPATH=/usr/lib/nspr' > ${D}/etc/env.d/50nspr
}
