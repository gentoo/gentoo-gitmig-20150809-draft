# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-0.10.5.ebuild,v 1.5 2002/07/11 06:30:47 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://fwbuilder.sourceforge.net"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="( >=dev-libs/libsigc++-1.0.4-r1
	 <dev-libs/libsigc++-1.1.0 )
	>=dev-libs/libxslt-1.0.7-r1
	>=net-analyzer/ucd-snmp-4.2.3
	ssl? ( dev-libs/openssl )"

src_compile() {
	
	local myconf
	
	use static && myconf="${myconf} --disable-shared --enable-static=yes"
	use ssl || myconf="${myconf} --without-openssl"
	
    ./configure 	\
		--prefix=/usr	\
		--host=${CHOST}	\
		${myconf} || die

    if [ "`use static`" ] ; then
        make LDFLAGS="-static" || die
    else
        make || die
    fi

}

src_install () {

    make DESTDIR=${D} install || die
    prepalldocs

}

