# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.2_beta1.ebuild,v 1.1 2002/12/03 11:34:12 bcowan Exp $

IUSE="ssl"

MY_P="${P/_/}"
S=${WORKDIR}/${PN}

DESCRIPTION="A Remote Desktop Protocol Client"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://rdesktop.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-base/xfree 
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	
	local myconf
	use ssl \
		&& myconf="--with-openssl" \
		|| myconf="--without-openssl"
	    
	[ "${DEBUG}" ] && myconf="${myconf} --with-debug"
	
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man $myconf || die
	
	use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf
	
	#Hold on tight folks, this ain't purdy
	
	if [ ! -z "${CXXFLAGS}" ]; then
		sed -e 's/-O2//g' Makefile > Makefile.tmp && mv Makefile.tmp Makefile
		echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	fi
	
	emake || die 
}

src_install () {
	
	dobin rdesktop
	doman doc/rdesktop.1
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
