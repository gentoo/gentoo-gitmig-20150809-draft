# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r2.ebuild,v 1.4 2002/07/26 23:00:37 cselkirk Exp $

MY_P=${P/.10/-10}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.mrunix.net/webalizer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=sys-libs/db-1*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/libgd-1.8.3"


RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A} ; cd ${S}
	# fix --enable-dns; our db1 headers are in /usr/include/db1
	mv dns_resolv.c dns_resolv.c.orig
	sed -e 's%^\(#include \)\(<db.h>\)\(.*\)%\1<db1/db.h>\3%' \
		dns_resolv.c.orig > dns_resolv.c
}

src_compile() {
	econf \
		--enable-dns \
		--with-etcdir=/etc/apache/conf || die
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
