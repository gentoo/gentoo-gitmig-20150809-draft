# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10.ebuild,v 1.1 2002/04/19 17:21:51 woodchip Exp $

MY_P=${P/.10/-10}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webalizer"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.mrunix.net/webalizer/"

DEPEND="virtual/glibc
	>=media-libs/libgd-1.8.3
	media-libs/libpng
	>=sys-libs/zlib-1.1.4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-etcdir=/etc/apache/conf \
		--mandir=/usr/share/man || die
	make || die
}

src_install() {
	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1
	insinto /etc/apache/conf
	newins ${FILESDIR}/webalizer-${PV}.conf webalizer.conf
	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/apache.webalizer
	dodoc README* CHANGES COPYING Copyright sample.conf
}

pkg_postinst() {
	install -d -o root -g root -m0755 ${ROOT}/home/httpd/htdocs/webalizer

	einfo
	einfo "Execute: \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with webalizer."
	einfo
}

pkg_config() {
	echo "Include  conf/addon-modules/apache.webalizer" \
		>> ${ROOT}/etc/apache/conf/apache.conf
}
