# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/nget/nget-0.19.1.ebuild,v 1.1 2002/07/19 20:59:21 rphillips Exp $

NPVER=20011209
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/nget/nget-0.19.1+uulib.tar.gz"
HOMEPAGE="http://nget.sourceforge.net/"
RDEPEND="virtual/glibc"
DEPEND="$RDEPEND dev-libs/popt"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${P}+uulib.tar.gz
}

src_compile() {
	local myconf
#	use nls || myconf="--disable-nls"
#	use ssl && myconf="${myconf} --with-ssl"
#	use ssl || myconf="${myconf} --without-ssl --disable-opie --disable-digest"
#	[ -z "$DEBUG" ] && myconf="${myconf} --disable-debug"
#	use ssl && CFLAGS="${CFLAGS} -I/usr/include/openssl"
	./configure --prefix=/usr  \
		--infodir=/usr/share/info --mandir=/usr/share/man $myconf || die
	if use static; then
		make LDFLAGS="--static" || die
	else
		make || die
	fi
}

src_install() {   
	if use build || use bootcd; then
		insinto /usr
		dobin ${S}/src/nget	
		return
	fi                      
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die
	dodoc COPYING ChangeLog FAQ README TODO 
}
