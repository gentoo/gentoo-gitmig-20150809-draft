# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-0.9.0.ebuild,v 1.7 2004/07/26 22:38:13 stkn Exp $

IUSE="alsa doc gtk mmx mysql nopri nozaptel"

inherit eutils webapp-apache

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/asterisk/old-releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/libc
	media-sound/mpg123
	dev-libs/newt
	doc? ( app-doc/doxygen )
	alsa? ( media-libs/alsa-lib )
	mysql? ( dev-db/mysql )
	gtk? ( =x11-libs/gtk+-1.2* )
	!nopri? ( >=net-libs/libpri-0.4 )
	!nozaptel? ( >=net-misc/zaptel-0.9.1
		     >=net-libs/zapata-0.9.1 )"

pkg_setup() {
	NO_WEBSERVER=0

	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	if [ $NO_WEBSERVER -eq 0 ]; then
		einfo "Voicemail webapp will be installed into: ${ROOT}${HTTPD_ROOT}"
	else
		einfo "Skipping installation of Voicemail webapp"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
#	epatch ${FILESDIR}/${PV}/${P}-makefile-fix.diff

	# set cflags & mmx optimization
	sed -i -e "s:^\(OPTIMIZE=\).*:\1 ${CFLAGS}:" Makefile

	if use mmx; then
		einfo "enabling mmx optimization"
		sed -i -e "s:^#\(K6OPT.*\):\1:" Makefile
	fi

	# change image path in voicemail cgi
	sed -i -e "s:^\(\$astpath = \).*:\1 \"/asterisk\";:" contrib/scripts/vmail.cgi
}

src_compile() {
	# build asterisk first...
	einfo "Building Asterisk..."
	cd ${S}
	emake -j1 || die "Make failed"
}

src_install() {
	emake -j1 DESTDIR=${D} install || die "Make install failed"
	emake -j1 DESTDIR=${D} samples || die "Make install samples failed"

	# install addmailbox and astgenkey
	dosbin contrib/scripts/addmailbox
	dosbin contrib/scripts/astgenkey

	# documentation
	use doc && \
		emake -j1 DESTDIR=${D} progdocs

	# voicemail webapp
	if [ $NO_WEBSERVER -eq 0 ]; then
	    einfo "Installing voicemail webapp"
	    insinto ${HTTPD_CGIBIN}
	    doins contrib/scripts/vmail.cgi
	    fperms 1755 ${HTTPD_CGIBIN}/vmail.cgi

	    insinto ${HTTPD_ROOT}/asterisk
	    for i in "images/*.gif"; do
		doins $i
	    done
	fi


	# install necessary files
	dodir /etc/env.d
	echo "LD_LIBRARY_PATH=\"/usr/lib/asterisk\"" > ${D}/etc/env.d/25asterisk

	exeinto /etc/init.d
	newexe  ${FILESDIR}/${PV}/asterisk.rc6 asterisk

	insinto /etc/conf.d
	newins  ${FILESDIR}/${PV}/asterisk.confd asterisk

	# don't delete these, even if they are empty
	keepdir /var/spool/asterisk/voicemail/default/1234/INBOX
	keepdir /var/log/asterisk/cdr-csv

	# install standard docs...
	dodoc BUGS CREDITS LICENSE ChangeLog HARDWARE README SECURITY

	docinto scripts
	dodoc contrib/scripts/*.pl
	dodoc contrib/scripts/*.sql
}

pkg_postinst() {
	einfo "Asterisk has been installed"
	einfo ""
	einfo "to add new Mailboxes use: /usr/sbin/addmailbox"
	einfo ""
	einfo "If you want to know more about asterisk, visit these sites:"
	einfo "http://www.automated.it/guidetoasterisk.htm"
	einfo "http://asterisk.xvoip.com/"
	einfo "http://www.voip-info.org/wiki-Asterisk"
	einfo "http://ns1.jnetdns.de/jn/relaunch/asterisk/"
}
