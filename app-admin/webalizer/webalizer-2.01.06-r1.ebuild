# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.06-r1.ebuild,v 1.1 2002/04/12 22:35:06 seemant Exp $

MY_P=${P/.06/-06}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webalizer"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.mrunix.net/webalizer/"

DEPEND=">=media-libs/libgd-1.8.3"

RDEPEND="media-libs/libpng"

src_compile() {
	./configure 	\
		--host=${CHOST}	\
		--prefix=/usr	\
		--with-etcdir=/etc/httpd	\
		--mandir=/usr/share/man	\
		|| die

	make || die
}

src_install() {

	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1
	dodir /usr/local/httpd/webalizer
	insinto /etc/httpd
	newins ${FILESDIR}/webalizer-${PV}.conf webalizer.conf
	doins ${FILESDIR}/httpd.webalizer
	dodoc README* CHANGES COPYING Copyright sample.conf

}
