# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-lite/pcsc-lite-1.1.1.ebuild,v 1.2 2003/02/13 16:10:40 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://www.linuxnet.com/middle.html"
LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
SRC_URI="http://www.linuxnet.com/middleware/files/pcsc-lite-1.1.1.tar.gz"
DEPEND="sys-devel/make
	sys-devel/libtool"

# moved from dev-util
PROVIDES="dev-util/pcsc-lite-1.1.1"

src_unpack () {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
}   

src_compile() {
	./configure \
		--enable-confdir=/etc \
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {

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
