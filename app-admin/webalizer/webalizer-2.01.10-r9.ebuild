# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.10-r9.ebuild,v 1.2 2005/07/07 22:26:03 rl03 Exp $

# uses webapps to create directories with right permissions
# probably slight overkil but works well
inherit eutils depend.apache webapp

MY_PV=${PV/.10/-10}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.mrunix.net/webalizer/"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/${MY_P}-src.tar.bz2
	geoip? ( http://sysd.org/proj/geolizer_${MY_PV}-patch.20040216.tar.bz2 )"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64"
IUSE="apache2 geoip"

DEPEND="=sys-libs/db-4.1*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3
	geoip? ( dev-libs/geoip )"

pkg_setup() {
	webapp_pkg_setup
	# prevents "undefined reference" errors... see bug #65163
	if ! built_with_use media-libs/gd png; then
		ewarn "media-libs/gd must be built with png for this package"
		ewarn "to function."
		die "recompile gd with USE=\"png\""
	fi
}

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

	# this enables the package to use db4.1, fixing bug #65399
	epatch ${FILESDIR}/${PN}-db4.patch
}

src_compile() {
	local myconf
	if use geoip; then
		myconf="--enable-geoip"
	else
		myconf="--enable-dns"
	fi
	myconf="${myconf} --with-db=/usr/include/db4.1/"
	autoconf # stupid broken configure file
	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	webapp_src_preinst

	into /usr
	dobin webalizer
	dosym webalizer /usr/bin/webazolver
	doman webalizer.1

	insinto /etc
	doins ${FILESDIR}/${PV}/webalizer.conf
	use apache2 && sed -i -e "s/apache/apache2/g" ${D}/etc/webalizer.conf

	if use apache2; then
		insinto ${APACHE2_MODULES_CONFDIR}
	else
		insinto ${APACHE1_MODULES_CONFDIR}
	fi
	newins ${FILESDIR}/${PV}/apache.webalizer 55_webalizer.conf

	dodoc README* CHANGES Copyright sample.conf
	webapp_hook_script ${FILESDIR}/${PV}/reconfig
	webapp_src_install
}

pkg_postinst(){
	einfo
	einfo "It is suggested that you restart apache before using webalizer"
	einfo
	einfo "Just type webalizer to generate your stats."
	einfo "You can also use cron to generate them e.g. every day."
	einfo "They can be accessed via http://localhost/webalizer"
	einfo
	webapp_pkg_postinst
}
