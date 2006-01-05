# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-1.21.4.ebuild,v 1.1 2006/01/05 23:30:27 rl03 Exp $

inherit eutils webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www2.zoneminder.com/downloads/zm-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="mpeg mysql"

DEPEND="mysql ( >=dev-db/mysql-3 )
	>=media-libs/jpeg-6b
	>=net-www/apache-1.3.27-r3
	dev-lang/perl"

RDEPEND="mpeg? ( media-video/ffmpeg )
	virtual/php
	media-libs/netpbm
	dev-perl/DBD-mysql"

S=${WORKDIR}/zm-${PV}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-mysql=/usr \
		--with-webdir=${MY_HTDOCSDIR} \
		--with-cgidir=${MY_CGIBINDIR} \
		$(use_with mpeg ffmpeg)=/usr \
		--with-webuser=apache \
		--with-webgroup=apache || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst

	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO db/zmschema.sql
	dohtml README.html

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins zmconfig.pl ${FILESDIR}/zmconfig-gentoo.txt zmconfig_eml.txt zmconfig_msg.txt
	fperms 0700 /usr/share/${P}/zmconfig.pl

	dodir /var/log/${PN} && keepdir /var/log/${PN}
	fowners apache:apache /var/log/${PN}

	fperms 0644 /etc/zm.conf

	webapp_postinst_txt en ${FILESDIR}/postinstall.txt
	webapp_src_install
}
