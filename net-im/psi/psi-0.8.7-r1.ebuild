# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.8.7-r1.ebuild,v 1.1 2003/05/21 14:08:34 pauldv Exp $
inherit kde-functions

IUSE="ssl"

S=${WORKDIR}/${P}
QV="1.0"
SRC_URI="mirror://sourceforge/psi/${P}.tar.bz2
	mirror://sourceforge/psi/qssl-${QV}.tar.bz2"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

need-qt 3

newdepend "ssl? ( >=dev-libs/openssl-0.9.6c )"

src_unpack() {

	unpack ${P}.tar.bz2
	unpack qssl-${QV}.tar.bz2
	cd ${S}/src
	patch -p0 < ${FILESDIR}/gen2-branding-0.8.7.patch
	# A patch from cvs that fixes psi not shutting down with kde
	patch -p0 < ${FILESDIR}/0.8.7-shutdown.patch
}

src_compile() {
	
	./configure --prefix=/usr || die
	make || die
	mv src/psi psi

        if [ "`use ssl`" ]; then
                cd ${WORKDIR}/qssl-${QV}
                qmake qssl.pro
                make
        fi	


}

src_install() {

	export PREFIX=${D}/usr
	export BINDIR=$PREFIX/bin
	export LIBDIR=$PREFIX/share/psi

	dodir /usr/share/psi
	echo [Installing Psi]

	mkdir -p $BINDIR
	mkdir -p $LIBDIR

	echo Copying program to $BINDIR
	cp ./psi $BINDIR

	echo Copying additional files to $LIBDIR
	cp -r ./image $LIBDIR
	cp -r ./iconsets $LIBDIR
	cp -r ./sound $LIBDIR
	cp -r ./certs $LIBDIR

	dodoc README COPYING 



	if [ "`use ssl`" ]; then
		cd ${WORKDIR}/qssl-${QV}
		cp libqssl.so ${D}/usr/share/psi
		cd ${S}
	fi

}
