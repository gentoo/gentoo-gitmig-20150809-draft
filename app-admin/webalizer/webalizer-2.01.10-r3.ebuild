# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r3.ebuild,v 1.1 2003/06/22 19:33:01 woodchip Exp $

MY_P=${P/.10/-10}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.mrunix.net/webalizer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="=sys-libs/db-1*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/libgd-1.8.3"

src_unpack() {
	unpack ${A} ; cd ${S}
	# fix --enable-dns; our db1 headers are in /usr/include/db1
	mv dns_resolv.c dns_resolv.c.orig
	sed -e 's%^\(#include \)\(<db.h>\)\(.*\)%\1<db1/db.h>\3%' \
		dns_resolv.c.orig > dns_resolv.c
}

src_compile() {
	econf --enable-dns || die
	make || die
}

src_install() {
	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	newins ${FILESDIR}/webalizer-${PV}.conf webalizer.conf

	if [ "`use apache2`" ]; then
		# patch for apache2
		cp ${D}/etc/webalizer.conf ${D}/etc/webalizer.conf.1;
		sed -e "s/apache/apache2/g" ${D}/etc/webalizer.conf.1 > ${D}/etc/webalizer.conf;
		rm ${D}/etc/webalizer.conf.1
		insinto /etc/apache2/conf
	else
		insinto /etc/apache/conf
	fi

	doins ${FILESDIR}/apache.webalizer
	dodoc README* CHANGES COPYING Copyright sample.conf
	dodir /home/httpd/htdocs/webalizer
}

pkg_postinst() {
	einfo
	einfo "Execute: \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with webalizer."
	einfo
}

pkg_config() {
	if [ "`use apache2`" ]; then
		CONF="/etc/apache2/conf/apache2.conf"
	else
		CONF="/etc/apache/conf/apache.conf"
	fi
	echo "Include  conf/apache.webalizer" \
		>> ${ROOT}${CONF}
}
