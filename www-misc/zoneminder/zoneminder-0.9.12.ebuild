# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-0.9.12.ebuild,v 1.3 2004/11/22 12:24:18 dragonheart Exp $

inherit eutils

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www.zoneminder.com/fileadmin/downloads/zm-${PV}.tar.gz
	http://mkeadle.org/distfiles/${PN}-gentoo.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mpeg"

DEPEND=">=dev-db/mysql-3*
	>=media-libs/jpeg-6b
	>=net-www/apache-1.3.27-r3
	dev-lang/perl"

RDEPEND="mpeg? ( media-video/ffmpeg )
	virtual/php
	media-libs/netpbm
	dev-perl/DBD-mysql"

S=${WORKDIR}/zm-${PV}

src_compile() {
	cd ${S}
	epatch ${WORKDIR}/${PN}-gentoo/zm-0.9.12-gentoo.patch

	# Apache is flexible, so we should follow suit
	local datadir=`grep ^apache: /etc/passwd | cut -d: -f6`
	if [ -z "$datadir" ]
	then
		datadir="/home/httpd"
		eerror ":: Cannot find the apache user on your system! ::"
		eerror "If you would like to customize where ${PN} installs its web related"
		eerror "files please create the apache user and set its home directory."
		ewarn "Defaulting to \"/home/httpd\"."
	else
		einfo "$datadir is your Apache data directory ..."
	fi

	HTTPD_DOCROOT="${datadir}/htdocs"
	HTTPD_CGIROOT="${datadir}/cgi-bin"
	HTTPD_USER="apache"
	HTTPD_GROUP="apache"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-mysql=/usr \
		--with-webdir=${HTTPD_DOCROOT}/zoneminder \
		--with-cgidir=${HTTPD_CGIROOT} \
		--with-webuser=${HTTPD_USER} \
		--with-webgroup=${HTTPD_GROUP} || die "./configure failed"

	cp "${WORKDIR}/${PN}-gentoo/zmconfig-gentoo.txt" ${S}
	cd ${S} && perl zmconfig.pl -f zmconfig-gentoo.txt -noi

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.html TODO
}
