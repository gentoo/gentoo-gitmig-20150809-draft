# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-1.22.3.ebuild,v 1.1 2006/12/11 02:00:57 rl03 Exp $

inherit eutils webapp autotools depend.php depend.apache

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
MY_PV=${PV/_/-}
MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www.zoneminder.com/downloads/${MY_PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="mpeg"

DEPEND="
	>=media-libs/jpeg-6b
	>=dev-lang/perl-5.6.0
	dev-perl/DBI
	dev-perl/DBD-mysql
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes
	dev-perl/DateManip
	dev-perl/libwww-perl
	dev-perl/Device-SerialPort
	virtual/perl-libnet
	dev-perl/Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/MIME-Lite
	dev-perl/MIME-tools
	virtual/perl-Sys-Syslog
	dev-perl/X10
	app-admin/sudo
"

want_apache
need_php_httpd

RDEPEND="mpeg? ( media-video/ffmpeg )
	media-libs/netpbm
	dev-perl/DBD-mysql"

S=${WORKDIR}/${MY_PN}-${MY_PV}

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use mysql
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.am.patch
	epatch ${FILESDIR}/zm_create.sql.in.diff
}

src_compile() {
	eautoreconf

	local MY_CONF="--with-mysql=/usr \
		--with-webdir=${MY_HTDOCSDIR} \
		--with-cgidir=${MY_CGIBINDIR} \
		--with-webuser=apache \
		--with-webgroup=apache"
	use mpeg && MY_CONF="${MY_CONF} --with-ffmpeg=/usr"

	econf ${MY_CONF} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst

	keepdir /var/run/zm
	emake -j1 DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.[prt]* TODO
	dohtml README.html

	dodir /usr/share/${PN}/db
	cp db/zm_u* db/zm_create.sql ${D}/usr/share/${PN}/db

	for DIR in events images sound; do
		dodir ${MY_HTDOCSDIR}/${DIR}
		webapp_serverowned ${MY_HTDOCSDIR}/${DIR}
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-2.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade.txt
	webapp_src_install
	fperms 0644 /etc/zm.conf

	keepdir /var/log/${PN}
	fowners apache:apache /var/log/${PN}
	fowners apache:apache /var/run/zm

	newinitd ${FILESDIR}/init.d zoneminder
	newconfd ${FILESDIR}/conf.d zoneminder
}
