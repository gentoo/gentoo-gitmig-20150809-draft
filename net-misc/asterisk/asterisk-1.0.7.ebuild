# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.0.7.ebuild,v 1.2 2005/03/27 22:53:10 stkn Exp $

IUSE="alsa doc gtk mmx mysql pri zaptel uclibc debug postgres vmdbmysql vmdbpostgres bri hardened speex resperl"

inherit eutils perl-module

ADDONS_VERSION="1.0.7"
BRI_VERSION="0.2.0-RC7k"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/${PN}/${P}.tar.gz
	 ftp://ftp.asterisk.org/pub/telephony/${PN}/${PN}-addons-${ADDONS_VERSION}.tar.gz
	 bri? http://www.junghanns.net/${PN}/downloads/bristuff-${BRI_VERSION}.tar.gz"

S=${WORKDIR}/${P}
S_ADDONS=${WORKDIR}/${PN}-addons-${ADDONS_VERSION}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~amd64"

DEPEND="dev-libs/newt
	media-sound/mpg123
	media-sound/sox
	doc? ( app-doc/doxygen )
	gtk? ( =x11-libs/gtk+-1.2* )
	pri? ( >=net-libs/libpri-1.0.3 )
	bri? ( >=net-libs/libpri-1.0.6
		>=net-misc/zaptel-1.0.6 )
	alsa? ( media-libs/alsa-lib )
	mysql? ( dev-db/mysql )
	speex? ( media-libs/speex )
	uclibc? ( sys-libs/uclibc )
	zaptel? ( >=net-misc/zaptel-1.0.3 )
	postgres? ( dev-db/postgresql )
	vmdbmysql? ( dev-db/mysql )
	vmdbpostgres? ( dev-db/postgresql )
	resperl? ( dev-lang/perl
		   >=net-misc/zaptel-1.0.3 )"

pkg_setup() {
	einfo "Running some pre-flight checks..."
	if use resperl; then
		# res_perl pre-flight check...
		if ! $(perl -V | grep -q "usemultiplicity=define"); then
			eerror "Embedded perl add-on needs Perl with built-in threads support"
			eerror "(rebuild perl with ithreads use-flag enabled)"
			die "Perl w/o threads support..."
		fi
		einfo "Perl with ithreads support found"
	fi


	# mysql and postgres voicemail support are mutually exclusive..
	if use vmdbmysql && use vmdbpostgres; then
		eerror "MySQL and PostgreSQL Voicemail support are mutually exclusive... choose one!"
		die "Conflicting use-flags"
	fi

	# check if zaptel and libpri have been built with bri enabled
	if use bri; then
		if ! built_with_use zaptel bri; then
			eerror "Re-emerge zaptel with bri use-flag enabled!"
			die "Zaptel without bri support detected"
		fi

		if ! built_with_use libpri bri; then
			eerror "Re-emerge libpri with bri use-flag enabled!"
			die "Libpri without bri support detected"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# set cflags & mmx optimization
	sed -i  -e "s:^\(OPTIMIZE+=\).*:\1 ${CFLAGS}:" \
		-e "s:^\(CFLAGS+=\$(shell if \$(CC)\):#\1:" \
		Makefile

	# gsm codec still uses -fomit-frame-pointer, and other codecs have their
	# own flags. We only change the arch.
	sed -i  -e "s:^OPTIMIZE+=.*:OPTIMIZE=${CFLAGS}:" \
		-e "s:^CFLAGS[\t ]\++=:CFLAGS =:" \
		codecs/gsm/Makefile

	# hppa patch for gsm codec
	epatch ${FILESDIR}/1.0.0/${PN}-1.0.5-hppa.patch

	if use mmx; then
		if ! use hardened; then
			einfo "Enabling mmx optimization"
			sed -i  -e "s:^#\(K6OPT[\t ]\+= -DK6OPT\):\1:" \
				codecs/gsm/Makefile
		else
			ewarn "Hardened use-flag is set, not enabling mmx optimization for codec_gsm!"

		fi
	fi
	if ! use mmx || use hardened; then
		# don't build + link asm mmx object file
		# without this codec_gsm.so will include text relocations
		sed -i  -e "/k6opt\.\(s\|o\)/ d" \
			codecs/gsm/Makefile
	fi

	if ! use debug; then
		einfo "Disabling debugging"
		sed -i -e "s:^\(DEBUG=\):#\1:" Makefile
	fi

	# change image path in voicemail cgi
	sed -i -e "s:^\(\$astpath = \).*:\1 \"/asterisk\";:" contrib/scripts/vmail.cgi

	#
	# embedded perl
	#
	if use resperl; then
		einfo "Patching asterisk for embedded perl support..."
		epatch ${S_ADDONS}/res_perl/astmake.diff

		# create necessary .c file
		/usr/bin/perl -MExtUtils::Embed -e xsinit || die "Could not create perlxsi.c"

		cd ${S_ADDONS}

		# fix perl path, source location and remove res_musiconhold
		sed -i -e "s:/usr/local/bin/perl:/usr/bin/perl:" \
			res_perl/Makefile \
			${S}/Makefile \
			res_perl/INC/*.pm
		sed -i -e "s:^ASTSRC.*:ASTSRC = ${S}:" \
			-e "s:\$(ASTLIBDIR)/modules/res_musiconhold.so::" \
			res_perl/Makefile

		cd ${S}
	fi

	#
	# uclibc patch
	#
	if use uclibc; then
		einfo "Patching asterisk for uclibc..."
		epatch ${FILESDIR}/1.0.0/${PN}-1.0.5-uclibc-dns.diff
	fi

	#
	# other patches
	#

	# asterisk-config
	epatch ${FILESDIR}/1.0.0/${PN}-1.0.5-astcfg-0.0.2.diff

	#
	# database voicemail support
	#
	if use postgres; then
		sed -i  -e "s:^#\(APPS+=app_sql_postgres.so\):\1:" \
			-e "s:/usr/local/pgsql/include:/usr/include/postgresql/pgsql:" \
			-e "s:/usr/local/pgsql/lib:/usr/lib/postgresql:" \
			apps/Makefile
	fi

	if use vmdbpostgres; then
		einfo "Enabling PostgreSQL voicemail support"
		sed -i  -e "s:^\(USE_POSTGRES_VM_INTERFACE\).*:\1=1:" \
			-e "s:/usr/local/pgsql/include:/usr/include/postgresql/pgsql:" \
			-e "s:/usr/local/pgsql/lib:/usr/lib/postgresql:" \
			apps/Makefile

		# patch app_voicemail.c
		sed -i -e "s:^#include <postgresql/libpq-fe\.h>:#include \"libpq-fe\.h\":" \
			apps/app_voicemail.c

	elif use vmdbmysql; then
		einfo "Enabling MySQL voicemail support"
		sed -i  -e "s:^\(USE_MYSQL_VM_INTERFACE\).*:\1=1:" \
			-e "s:^\(CFLAGS+=-DUSEMYSQLVM\):\1 -I${S_ADDONS}:" \
			apps/Makefile
	fi

	#
	# asterisk add-ons
	#
	cd ${S_ADDONS}
	sed -i -e "s:-I../asterisk:-I${S} -I${S}/include:" Makefile
	sed -i  -e "s:^OPTIMIZE+=.*:OPTIMIZE+=${CFLAGS}:" \
		-e "s:^\(CFLAGS=\)\(.*\):\1-I${S}/include -fPIC \2:" \
		format_mp3/Makefile


	#
	# BRI patches
	#
	if use bri; then
		cd ${S}
		einfo "Patching asterisk w/ BRI stuff"

		# fix patch for new asterisk version...
		sed -i -e "s:^\([+-]\)1.0.6:\1${PV}:" \
			${WORKDIR}/bristuff-${BRI_VERSION}/patches/asterisk.patch

		epatch ${WORKDIR}/bristuff-${BRI_VERSION}/patches/asterisk.patch
	fi

	#
	# Revived snmp plugin support
	#
#	if use snmp; then
#		cd ${S}
#		einfo "Patching snmp plugin helper functions"
#		epatch ${FILESDIR}/1.0.0/ast-ax-snmp-1.0.6.diff
#	fi
}

src_compile() {
	# build asterisk first...
	einfo "Building Asterisk..."
	cd ${S}
	emake -j1 || die "Make failed"

	#
	# add-ons
	#
	einfo "Building additional stuff..."
	cd ${S_ADDONS}
	emake -j1 || die "Make failed"

	if use resperl; then
		cd ${S_ADDONS}/res_perl
		emake -j1 || die "Building embedded perl failed"
	fi
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

# rem	# install necessary files
#	dodir /etc/env.d
#	echo "LD_LIBRARY_PATH=\"/usr/lib/asterisk\"" > ${D}/etc/env.d/25asterisk

	exeinto /etc/init.d
	newexe  ${FILESDIR}/1.0.0/asterisk.rc6 asterisk

	insinto /etc/conf.d
	newins  ${FILESDIR}/1.0.0/asterisk.confd asterisk

	# don't delete these, even if they are empty
	keepdir /var/spool/asterisk/voicemail/default/1234/INBOX
	keepdir /var/spool/asterisk/tmp
	keepdir /var/log/asterisk/cdr-csv

	# install standard docs...
	dodoc BUGS CREDITS LICENSE ChangeLog HARDWARE README README.fpm SECURITY

	docinto scripts
	dodoc contrib/scripts/*
	docinto firmware/iax
	dodoc contrib/firmware/iax/*

	insinto /usr/share/doc/${PF}/cgi
	doins contrib/scripts/vmail.cgi
	for i in "images/*.gif"; do
		doins $i
	done

	#
	# add-ons
	#

	# install additional modules...
	einfo "Installing additional modules..."
	cd ${S_ADDONS}
	emake -j1 INSTALL_PREFIX=${D} install || die "Make install failed"

	if use resperl; then
		perlinfo

		cd ${S_ADDONS}/res_perl
		emake -j1 INSTALL_PREFIX=${D} install || die "Installation of perl AST_API failed"

		# move AstApiBase.so to a proper place
		dodir ${VENDOR_LIB}/auto/AstAPIBase
		mv ${D}/etc/asterisk/perl/AstAPIBase.so ${D}${VENDOR_LIB}/auto/AstAPIBase

		# move *.pm files to other location
		dodir ${VENDOR_LIB}/AstAPI
		dodir ${VENDOR_LIB}/AstAPIBase
		for x in AstAPI.pm AstConfig.pm LoadFile.pm PerlSwitch.pm WebServer.pm; do
			mv ${D}/etc/asterisk/perl/${x} ${D}${VENDOR_LIB}/AstAPI
			dosed "s/^use[\t ]\+${x/.pm/};/use AstAPI::${x/.pm/};/" /etc/asterisk/perl/asterisk_init.pm
		done
		mv ${D}/etc/asterisk/perl/AstAPIBase.pm ${D}${VENDOR_LIB}/AstAPIBase
		dosed "s/^use[\t ]\+AstAPI;/use AstAPI::AstAPI;/" /etc/asterisk/perl/asterisk_init.pm
		dosed "s/^use[\t ]\+AstAPIBase;/use AstAPIBase::AstAPIBase;/" ${VENDOR_LIB}/AstAPI/AstAPI.pm

		# move apps + htdocs to a proper place
		dodir /var/lib/asterisk/perl
		mv ${D}/etc/asterisk/perl/{apps,htdocs} ${D}/var/lib/asterisk/perl

		# fix locations
		sed -i -e "s:/etc/asterisk/perl:/var/lib/asterisk/perl:" \
			${D}${VENDOR_LIB}/AstAPI/LoadFile.pm ${D}${VENDOR_LIB}/AstAPI/WebServer.pm
	fi
}

pkg_postinst() {
	einfo "Asterisk has been installed"
	einfo ""
	einfo "to add new Mailboxes use: /usr/sbin/addmailbox"
	einfo ""
	einfo "If you want to know more about asterisk, visit these sites:"
	einfo "http://www.asteriskdocs.org/"
	einfo "http://www.voip-info.org/wiki-Asterisk"
	echo
	einfo "http://asterisk.xvoip.com/"
	einfo "http://junghanns.net/asterisk/"
	einfo "http://www.automated.it/guidetoasterisk.htm"
	echo
	einfo "Gentoo VoIP IRC Channel:"
	einfo "#gentoo-voip @ irc.freenode.net"
	echo
	ewarn "Additional sounds have been split-out into"
	ewarn "net-misc/asterisk-sounds"
}
