# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.2.4.ebuild,v 1.4 2006/03/13 21:53:22 stkn Exp $

inherit eutils

IUSE="alsa bri curl debug doc gtk h323 hardened lowmem mmx mysql \
	nosamples odbc osp postgres pri speex sqlite ssl ukcid zaptel"

BRI_VERSION="0.3.0-PRE-1h"
AST_PATCHES="1.2.1-patches-1.0"

## TODO:
#
# - uclibc patch still needed? (still applies)
# - test nosamples
# - add some more use flags...
#	recent additions: osp, lowmem, curl, ukcid
# - cleanup

MY_P="${P/_/-}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/old-releases/${MY_P}.tar.gz
	 http://www.netdomination.org/pub/asterisk/${PN}-${AST_PATCHES}.tar.bz2
	 bri? ( http://www.netdomination.org/pub/asterisk/asterisk-${PV}-bristuff-${BRI_VERSION}.diff.gz
		http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"
#	 bri? (	http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_P}"
S_BRI="${WORKDIR}/bristuff-${BRI_VERSION}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

RDEPEND="dev-libs/newt
	media-sound/sox
	media-sound/mpg123
	ssl? ( dev-libs/openssl )
	gtk? ( =x11-libs/gtk+-1.2* )
	pri? ( >=net-libs/libpri-1.2.0 )
	h323? ( >=dev-libs/pwlib-1.8.3
		>=net-libs/openh323-1.15.0 )
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	speex? ( media-libs/speex )
	sqlite? ( <dev-db/sqlite-3.0.0 )
	zaptel? ( >=net-misc/zaptel-1.2.0 )
	postgres? ( dev-db/postgresql )
	osp? ( >=net-libs/osptoolkit-3.3.4 )
	bri? (  >=net-libs/libpri-1.2.2
		>=net-misc/zaptel-1.2.3 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	doc? ( app-doc/doxygen )"

pkg_setup() {
	ewarn "                      Asterisk UPGRADE Warning"
	ewarn ""
	ewarn "!!! Read ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.gz after installation !!!"
	ewarn ""
	ewarn "                      Asterisk UPGRADE Warning"
	echo
	einfo "Press Ctrl+C to abort"
	echo
	ebeep

	n=10
	while [[ $n -gt 0 ]]; do
		echo -en "  Waiting $n seconds...\r"
		sleep 1
		(( n-- ))
	done

	#
	# Regular checks
	#
	einfo "Running some pre-flight checks..."

	# check if zaptel and libpri have been built with bri enabled
	if use bri; then
		if ! built_with_use net-misc/zaptel bri; then
			eerror "Re-emerge zaptel with bri use-flag enabled!"
			die "Zaptel without bri support detected"
		fi

		if ! built_with_use net-libs/libpri bri; then
			eerror "Re-emerge libpri with bri use-flag enabled!"
			die "Libpri without bri support detected"
		fi
	fi

}

src_unpack() {
	unpack ${A}
	cd ${S}

	#
	# gentoo patchset
	#
	for x in $(grep -v "^#\| \+" ${WORKDIR}/patches/patches.list); do
		epatch ${WORKDIR}/patches/${x}
	done

	if use mmx; then
		if ! use hardened; then
			einfo "Enabling mmx optimization"
			sed -i -e "s:^#\(K6OPT[\t ]\+= -DK6OPT\):\1:" \
				Makefile
		else
			ewarn "Hardened use-flag is set, not enabling mmx optimization for codec_gsm!"
		fi
	fi

	if ! use debug; then
		einfo "Disabling debug support"
		sed -i -e "s:^\(DEBUG=\):#\1:" \
			Makefile
	fi

	if ! use ssl; then
		einfo "Disabling crypto support"
		sed -i -e "s:^#\(NOCRYPTO=yes\):\1:" \
			Makefile
	fi

	#
	# uclibc patch
	#
	if use elibc_uclibc; then
		einfo "Patching asterisk for uclibc..."
		epatch ${FILESDIR}/1.0.0/${PN}-1.0.5-uclibc-dns.diff
		epatch ${FILESDIR}/1.2.0/${PN}-1.2.1-uclibc-getloadavg.diff
	fi

	#
	# ukcid patch from http://www.lusyn.com/asterisk/
	#
	if use ukcid; then
		einfo "Patching asterisk for UK Callerid..."
		epatch ${FILESDIR}/1.2.0/${PN}-1.2.0_beta-ukcid.patch
	fi

	#
	# BRI patches
	#
	if use bri; then
		einfo "Patching asterisk w/ BRI stuff"
#		epatch ${S_BRI}/patches/asterisk.patch
		epatch ${WORKDIR}/asterisk-${PV}-bristuff-${BRI_VERSION}.diff
	fi
}

src_compile() {
	local myopts

	use lowmem && \
		myopts="-DLOW_MEMORY"

	if use h323; then
		einfo "Building H.323 wrapper lib..."
		make -C channels/h323 \
			NOTRACE=1 \
			PWLIBDIR=/usr/share/pwlib \
			OPENH323DIR=/usr/share/openh323 \
			libchanh323.a Makefile.ast || die "Make h323 failed"
	fi

	einfo "Building Asterisk..."
	make \
		NOTRACE=1 \
		OPTIMIZE="${CFLAGS}" \
		PWLIBDIR=/usr/share/pwlib \
		OPENH323DIR=/usr/share/openh323 \
		OPTIONS="${myopts}" || die "Make failed"

	# create api docs
	use doc && \
		make progdocs

	# build bristuff's ISDNguard
	use bri && \
		make -C ${S_BRI}/ISDNguard
}

src_install() {

	# install asterisk
	make DESTDIR=${D} install || die "Make install failed"
	make DESTDIR=${D} samples || die "Failed to create sample files"

	# remove installed sample files if nosamples flag is set
	if use nosamples; then
		einfo "Skipping installation of sample files..."
		einfo "See ${ROOT}usr/share/doc/${PF}/configs for configuration files"
		insinto /usr/share/doc/${PF}/configs
		newins  ${D}etc/asterisk/asterisk.conf asterisk.conf.sample

		# skip installation of sample configuration files
		# if asterisk-1.1.0 or later is present
		if has_version ">net-misc/asterisk-1.1.0"
		then
			rm -f  ${D}etc/asterisk/*
		else
			einfo "No previous or old (<=1.0.x) installation of ${PN} found,"
			einfo "installing sample configuration files!"
		fi
		rm -rf ${D}var/spool/asterisk/voicemail/default
		rm -f  ${D}var/lib/asterisk/mohmp3/*
		rm -f  ${D}var/lib/asterisk/sounds/demo-*
		rm -f  ${D}var/lib/asterisk/agi-bin/*
	else
		einfo "Sample files have been installed"
		keepdir /var/spool/asterisk/voicemail/default/1234/INBOX
	fi

	# don't delete these directories, even if they are empty
	for x in voicemail meetme system dictate tmp; do
		keepdir /var/spool/asterisk/${x}
	done
	keepdir /var/lib/asterisk/sounds/priv-callerintros
	keepdir /var/lib/asterisk/mohmp3
	keepdir /var/lib/asterisk/agi-bin
	keepdir /var/log/asterisk/cdr-csv
	keepdir /var/log/asterisk/cdr-custom
	keepdir /var/run/asterisk

	# install asterisk.h, a lot of external modules need this
	insinto /usr/include/asterisk
	doins	include/asterisk.h

	# install astgenkey, astxs, safe_asterisk and manpages
	dobin  contrib/scripts/astxs
	dosbin contrib/scripts/astgenkey
	dosbin contrib/scripts/safe_asterisk
	doman contrib/scripts/safe_asterisk.8
	doman contrib/scripts/astgenkey.8

	newinitd ${FILESDIR}/1.0.0/asterisk.rc6.sec asterisk
	newconfd ${FILESDIR}/1.0.0/asterisk.confd.sec asterisk

	# install standard docs...
	dodoc BUGS CREDITS LICENSE ChangeLog HARDWARE README README.fpm
	dodoc SECURITY doc/CODING-GUIDELINES doc/linkedlists.README UPGRADE.txt
	dodoc doc/README.*
	dodoc doc/*.txt

	docinto scripts
	dodoc contrib/scripts/*

	docinto utils
	dodoc contrib/utils/*

	docinto configs
	dodoc configs/*

	# install api docs
	if use doc; then
		insinto /usr/share/doc/${PF}/api/html
		doins doc/api/html/*
	fi

	# install ISDNguard
	if use bri; then
		cd ${S_BRI}/ISDNguard
		dosbin ISDNguard

		docinto ISDNguard
		dodoc INSTALL.ISDNguard

		cd ${S}
	fi

	insinto /usr/share/doc/${PF}/cgi
	doins contrib/scripts/vmail.cgi
	doins images/*.gif
}

pkg_preinst() {
	enewgroup asterisk
	enewuser asterisk -1 -1 /var/lib/asterisk asterisk
}

pkg_postinst() {
	einfo "Fixing permissions"
	for x in spool run lib log; do
		chown -R asterisk:asterisk ${ROOT}var/${x}/asterisk
		chmod -R u=rwX,g=rX,o=     ${ROOT}var/${x}/asterisk
	done

	chown -R root:asterisk ${ROOT}etc/asterisk
	chmod -R u=rwX,g=rX,o= ${ROOT}etc/asterisk
	echo

	#
	# Announcements, warnings, reminders...
	#
	einfo "Asterisk has been installed"
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
	echo

	#
	# Permission and non-root warning
	#
	ewarn "*********************** Important information **************************"
	ewarn
	ewarn "- Asterisk runs as user asterisk, group asterisk by default"
	ewarn
	ewarn "- Make sure the asterisk user is a member of the proper groups if you want it"
	ewarn "  to have access to hardware devices, e.g. \"audio\" for Alsa and OSS sound or"
	ewarn "  \"dialout\" for zaptel!"
	ewarn
	ewarn "- Permissions of /etc/asterisk have been changed to root:asterisk"
	ewarn "  750 (rwxr-x--- directories) / 640 (rw-r----- files)"
	ewarn
	ewarn "- Permissions of /var/{log,lib,run,spool}/asterisk have been changed"
	ewarn "  to asterisk:asterisk 750 / 640"
	ewarn
	ewarn "- Asterisk's unix socket and pidfile are now in /var/run/astrisk"
	ewarn
	ewarn "- Asterisk cannot set the IP ToS bits when run as user,"
	ewarn "  use something like this to make iptables set them for you:"
	ewarn "  \"iptables -A OUTPUT -t mangle -p udp -m udp --dport 5060 -j DSCP --set-dscp 0x28\""
	ewarn "  \"iptables -A OUTPUT -t mangle -p udp -m udp --sport 10000:20000 -j DSCP --set-dscp 0x28\""
	ewarn "  (taken from voip-info.org comments (see below), thanks andrewid)"
	ewarn
	ewarn "For more details:"
	ewarn "     http://bugs.gentoo.org/show_bug.cgi?id=88732"
	ewarn "     http://www.voip-info.org/wiki-Asterisk+non-root"
	echo

	#
	# Warning about security changes...
	#
	ewarn "                      Asterisk UPGRADE Warning"
	ewarn ""
	ewarn "!!! Read ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.gz before continuing !!!"
	ewarn ""
	ewarn "                      Asterisk UPGRADE Warning"
}

pkg_config() {
	einfo "Do you want to reset file permissions and ownerships (y/N)?"

	read tmp
	tmp="$(echo $tmp | tr [:upper:] [:lower:])"

	if [[ "$tmp" = "y" ]] ||\
	   [[ "$tmp" = "yes" ]]
	then
		einfo "Resetting permissions to defaults..."

		for x in spool run lib log; do
			chown -R asterisk:asterisk ${ROOT}var/${x}/asterisk
			chmod -R u=rwX,g=rX,o=     ${ROOT}var/${x}/asterisk
		done

		chown -R root:asterisk ${ROOT}etc/asterisk
		chmod -R u=rwX,g=rX,o= ${ROOT}etc/asterisk

		einfo "done"
	else
		einfo "skipping"
	fi
}
