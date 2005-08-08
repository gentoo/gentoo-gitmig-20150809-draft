# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-1.21.3.ebuild,v 1.1 2005/08/08 21:40:46 rl03 Exp $

inherit eutils webapp

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www2.zoneminder.com/downloads/zm-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="mpeg"

DEPEND=">=dev-db/mysql-3
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

	cp ${FILESDIR}/zmconfig-gentoo.txt ${T}
	perl zmconfig.pl -f ${T}/zmconfig-gentoo.txt -noi

	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst

	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO db/zmschema.sql
	dohtml README.html
	dodir /var/log/zoneminder && keepdir /var/log/zoneminder

	fperms 0644 /etc/zm.conf

	webapp_postinst_txt en ${FILESDIR}/postinstall.txt
	webapp_src_install
}
