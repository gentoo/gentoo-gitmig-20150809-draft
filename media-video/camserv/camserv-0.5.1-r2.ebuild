# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.1-r2.ebuild,v 1.1 2003/06/19 19:03:50 mkeadle Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A streaming video server."
SRC_URI="mirror://sourceforge/cserv/${P}.tar.gz"
HOMEPAGE="http://cserv.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-libs/jpeg-6b-r2
	>=media-libs/imlib-1.9.13-r2"

src_compile() {

	_CC="${CC}"
	_CFLAGS="${CFLAGS}"
	_CXXFLAGS="${CXXFLAGS}"
	_CHOST="${CHOST}"
	unset CC
	unset CFLAGS
	unset CXXFLAGS
	unset CHOST

        ./configure \
           --prefix=/usr \
           --mandir=/usr/share/man \
           --infodir=/usr/share/info \
           --datadir=/usr/share \
           --sysconfdir=/etc \
           --localstatedir=/var/lib || die "./configure failed"

	CC="${_CC}"
	CFLAGS="${_CFLAGS}"
	CXXFLAGS="${_CXXFLAGS}"
	CHOST="${_CHOST}"

	emake || die

}

src_install () {

	einstall datadir=${D}/usr/share/${PN} || die

	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO javascript.txt
	dohtml defpage.html
	# new init script
	insinto /etc/init.d
	newins ${FILESDIR}/camserv.init camserv
	fperms +x /etc/init.d/camserv

}
