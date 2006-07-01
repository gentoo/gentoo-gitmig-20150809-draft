# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-1.22.2.ebuild,v 1.1 2006/07/01 05:48:19 rl03 Exp $

inherit eutils webapp autotools depend.php

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
MY_PV=${PV/_/-}
MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www.zoneminder.com/downloads/${MY_PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="mpeg mysql"

DEPEND="mysql? ( >=dev-db/mysql-3 )
	>=media-libs/jpeg-6b
	>=net-www/apache-1.3.27-r3
	>=dev-lang/perl-5.6.0
	dev-perl/DBI
	dev-perl/DBD-mysql
	perl-core/Getopt-Long
	perl-core/Time-HiRes
	dev-perl/DateManip
	dev-perl/libwww-perl
	dev-perl/Device-SerialPort
	perl-core/libnet
	dev-perl/Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/MIME-Lite
	dev-perl/MIME-tools
	|| ( perl-core/Sys-Syslog >=dev-lang/perl-5.8.8 )
	dev-perl/X10
"

need_php

RDEPEND="mpeg? ( media-video/ffmpeg )
	media-libs/netpbm
	dev-perl/DBD-mysql"

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.am.patch
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

	dodir /var/run/zm
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.[prt]* TODO
	dohtml README.html

	dodir /usr/share/${PN}/db
	cp db/zm_u* db/zm_create.sql ${D}/usr/share/${PN}/db

	keepdir /var/log/${PN}

	webapp_postinst_txt en ${FILESDIR}/postinstall-2.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade.txt
	webapp_src_install
	fperms 0644 /etc/zm.conf
	fowners apache:apache /var/log/${PN}

	newinitd ${FILESDIR}/init.d zoneminder
	newconfd ${FILESDIR}/conf.d zoneminder
}
