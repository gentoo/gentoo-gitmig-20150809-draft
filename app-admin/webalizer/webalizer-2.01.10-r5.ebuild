# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r5.ebuild,v 1.15 2006/02/23 15:39:49 rl03 Exp $

inherit eutils

MY_PV=${PV/.10/-10}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.mrunix.net/webalizer/"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2
	geoip? ( http://sysd.org/proj/geolizer_${MY_PV}-patch.20040216.tar.bz2 )
	mirror://gentoo/${PN}.conf.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ppc ppc64 ~sparc ~x86"
IUSE="apache2 geoip"

DEPEND="=sys-libs/db-1*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3
	geoip? ( dev-libs/geoip )"

src_unpack() {
	unpack ${A} ; cd ${S}
	# fix --enable-dns; our db1 headers are in /usr/include/db1
	#	mv dns_resolv.c dns_resolv.c.orig
	#	sed -e 's%^\(#include \)\(<db.h>\)\(.*\)%\1<db1/db.h>\3%' \
	#		dns_resolv.c.orig > dns_resolv.c
	sed -i -e "s,db_185.h,db.h," configure

	if use geoip; then
		cd ${WORKDIR}
		epatch ${WORKDIR}/geolizer_${MY_PV}-patch/geolizer.patch || die
	else
		# pretty printer for numbers
		cd ${S} && epatch ${FILESDIR}/output.c.patch || die
	fi
}

src_compile() {
	if use geoip; then
		myconf="`use_enable geoip`"
	else
		myconf="--enable-dns"
	fi
	myconf="${myconf} --with-db=/usr/include/db1/"
	einfo "Configuration: ${myconf}"
	econf ${myconf} || die
	make || die
}

src_install() {
	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	doins ${WORKDIR}/${PN}.conf

	if use apache2; then
		# patch for apache2
		sed -i -e "s/apache/apache2/g" ${D}/etc/webalizer.conf
		insinto /etc/apache2/conf
	else
		insinto /etc/apache/conf
	fi

	doins ${WORKDIR}/${PN}.conf

	use apache2 || insinto /etc/apache/conf/addon-modules
	use apache2 || newins ${FILESDIR}/${PV}/apache.webalizer webalizer.conf

	use apache2 && insinto /etc/apache2/conf/modules.d
	use apache2 && newins ${FILESDIR}/${PV}/apache.webalizer 55_webalizer.conf

	dodoc README* CHANGES Copyright sample.conf
	dodir /var/www/webalizer
}

pkg_postinst(){
	if use apache2; then
	einfo "to update your apache.conf just type"
	einfo "echo \"Include  conf/addon-modules/webalizer.conf\" \
		>> /etc/apache/conf/apache.conf"
	fi
	einfo
	einfo "Just type webalizer to generate your stats."
	einfo "You can also use cron to generate them e.g. every day."
	einfo "They can be accessed via http://localhost/webalizer"
	einfo
}
