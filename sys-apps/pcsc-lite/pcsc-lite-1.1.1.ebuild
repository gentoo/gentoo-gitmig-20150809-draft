# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-lite/pcsc-lite-1.1.1.ebuild,v 1.3 2003/04/24 10:57:11 vapier Exp $

inherit eutils

DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://www.linuxnet.com/middle.html"
SRC_URI="http://www.linuxnet.com/middleware/files/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"

DEPEND="sys-devel/make
	sys-devel/libtool"

src_unpack () {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${P}-gentoo.patch
}   

src_compile() {
	./configure \
		--enable-confdir=/etc \
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install() {
	emake prefix=${D}/usr install || die

	dodoc AUTHORS COPYING ChangeLog DRIVERS HELP INSTALL NEWS README SECURITY 
	insinto /usr/share/doc/${P} 
	doins doc/*.pdf doc/README.DAEMON

	insinto /usr/share/pcsc-lite/utils
	insopts -m755
	doins src/utils/bundleTool src/utils/formaticc src/utils/installifd
	insopts -m644
	doins src/utils/README src/utils/sample.*

	insinto /etc
	doins etc/reader.conf

	insinto /etc/init.d
	insopts -m755
	newins doc/pcscd.startup pcscd
}
