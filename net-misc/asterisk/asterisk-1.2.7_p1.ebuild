# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.2.7_p1.ebuild,v 1.1 2006/04/16 01:04:44 stkn Exp $

inherit eutils

IUSE="alsa bri curl debug doc genericjb gtk h323 hardened lowmem mmx mysql \
	nosamples odbc osp postgres pri speex sqlite ssl ukcid zaptel"

#IUSE="alsa bri curl debug doc gtk genericjb h323 hardened lowmem mmx mysql \
#	nosamples odbc osp postgres pri speex sqlite ssl t38 ukcid zaptel"

BRI_VERSION="0.3.0-PRE-1n"
AST_PATCHES="1.2.7-patches-1.0"
#T38_PATCHES="1.2.4-t38-20060216"
JB_PATCHES="1.2.5-genericjb-20060228"

## NOTE:
#

MY_P="${P/_p/.}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/${MY_P}.tar.gz
	 http://www.netdomination.org/pub/asterisk/${PN}-${AST_PATCHES}.tar.bz2
	 genericjb? ( http://www.netdomination.org/pub/asterisk/${PN}-${JB_PATCHES}.patch.gz )
	 bri? ( http://www.netdomination.org/pub/asterisk/${MY_P}-bristuff-${BRI_VERSION}.diff.bz2
		http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"

#	 t38? ( http://www.netdomination.org/pub/asterisk/${PN}-${T38_PATCHES}.tar.bz2 )
#	 bri? (	http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"


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
	pri? ( >=net-libs/libpri-1.2.2 )
	h323? ( >=dev-libs/pwlib-1.8.3
		>=net-libs/openh323-1.15.0 )
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	speex? ( media-libs/speex )
	sqlite? ( <dev-db/sqlite-3.0.0 )
	zaptel? ( >=net-misc/zaptel-1.2.5 )
	postgres? ( dev-db/postgresql )
	osp? ( >=net-libs/osptoolkit-3.3.4 )
	bri? (  >=net-libs/libpri-1.2.2
		>=net-misc/zaptel-1.2.5 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	doc? ( app-doc/doxygen )"


#
# List of modules to ignore during scan (because they have been removed in 1.2.x)
#
SCAN_IGNORE_MODS="
	app_qcall
	chan_modem
	chan_modem_i4l
	chan_modem_bestdata
	chan_modme_aopen"

#
# shortcuts
#
is_ast10update() {
	return $(has_version "=net-misc/asterisk-1.0*")
}

is_astupdate() {
	if ! is_ast10update; then
		return $(has_version "<net-misc/asterisk-${PV}")
	fi
	return 0
}

#
# Display a nice countdown...
#
countdown() {
	local n

	ebeep

	n=${1:-10}
	while [[ $n -gt 0 ]]; do
		echo -en "  Waiting $n second(s)...\r"
		sleep 1
		(( n-- ))
	done
}

#
# Scan for asterisk-1.0.x modules that will have to be updated
#
scan_modules() {
	local modules_list=""
	local n

	for x in $(ls -1 ${ROOT}usr/lib/asterisk/modules/*.so); do
		echo -en "Scanning.... $(basename ${x})   \r"

		# skip blacklisted modules
		hasq $(basename ${x//.so}) ${SCAN_IGNORE_MODS} && continue

		if $(readelf -s "${x}" | grep -q "\(ast_load\|ast_destroy\)$"); then
			modules_list="${modules_list} $(basename ${x//.so})"
		fi
	done

	if [[ -n "${modules_list}" ]]; then
		echo  "   ========================================================"
		ewarn "Please update or unmerge the following modules:"
		echo

		n=0
		for x in ${modules_list}; do
			ewarn " -   ${x}"
			(( n++ ))
		done

		echo
		ewarn "Warning: $n outdated module(s) found!"
		ewarn "Warning: asterisk may not work if you don't update them!"
		echo  "   ========================================================"
		echo
		einfo "You can use the \"asterisk-updater\" script to update the modules"
		echo
		countdown
		echo
		return 1
	else
		einfo "No asterisk-1.0.x modules found!"
		return 0
	fi
}

pkg_setup() {
	local checkfailed=0 waitaftermsg=0

	if is_ast10update; then
		ewarn "                      Asterisk UPGRADE Warning"
		ewarn ""
		ewarn "- Please read ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.gz after the installation!"
		ewarn ""
		ewarn "                      Asterisk UPGRADE Warning"
		echo
		waitaftermsg=1
	fi

#	if use t38; then
#		ewarn "********************** Experimental Feature **************************"
#		ewarn "Please note that T.38 pass-through support is experimental and may not"
#		ewarn "be included in newer versions!"
#		echo
#		waitaftermsg=1
#	fi

	if use genericjb; then
		ewarn "********************** Experimental Feature **************************"
		ewarn "Please note that generic jitterbuffer support is experimental and may not"
		ewarn "be included in newer versions!"
		echo
		waitaftermsg=1
	fi

	if [[ $waitaftermsg -eq 1 ]]; then
		einfo "Press Ctrl+C to abort"
		echo
		countdown
	fi

	#
	# Regular checks
	#
	einfo "Running some pre-flight checks..."
	echo

	# check if zaptel has been compiled with ukcid too
	if use ukcid; then
		if ! built_with_use net-misc/zaptel ukcid; then
			eerror "- ukcid: Re-emerge zaptel with \"ukcid\" useflag enabled!"
			checkfailed=1
		fi
	fi

	# check if zaptel and libpri have been built with bri enabled
	if use bri; then
		if ! built_with_use net-misc/zaptel bri; then
			eerror "- bri: Re-emerge zaptel with \"bri\" useflag enabled!"
			heckfailed=1
		fi

		if ! built_with_use net-libs/libpri bri; then
			eerror "- bri: Re-emerge libpri with \"bri\" useflag enabled!"
			checkfailed=1
		fi
	fi

	# stop here if checks failed
	[[ $checkfailed -eq 1 ]] && \
		die "Pre-flight check failed, see messages for more information!"
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

		epatch ${WORKDIR}/${MY_P}-bristuff-${BRI_VERSION}.diff
#		epatch ${S_BRI}/patches/asterisk.patch
	fi

	#
	# T.38 pass-through patch (asterisk bug #5090)
	#
#	if use t38; then
#		einfo "T.38 experimental pass-through support (ast #5090)"
#		epatch ${WORKDIR}/asterisk-${T38_PATCHES}-udptl.patch
#
#		if use bri; then
#			epatch ${WORKDIR}/asterisk-${T38_PATCHES}-bri.patch
#		else
#			epatch ${WORKDIR}/asterisk-${T38_PATCHES}-nobri.patch
#		fi
#	fi

	#
	# Generic jitterbuffer (asterisk bug #3854)
	#
	if use genericjb; then
		einfo "Generic jitterbuffer (ast #3854)"
		epatch ${WORKDIR}/${PN}-${JB_PATCHES}.patch

		sed -i -e "s:^\(GENERIC_JB = \)#-DAST_JB:\1 -DAST_JB:" \
			Makefile
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

	# remove bristuff capi
	use bri && \
		rm -f ${D}usr/lib/asterisk/modules/{app,chan}_capi*.so 2>/dev/null

	# remove installed sample files if nosamples flag is set
	if use nosamples; then
		einfo "Skipping installation of sample files..."
		rm -rf ${D}var/spool/asterisk/voicemail/default
		rm -f  ${D}var/lib/asterisk/mohmp3/*
		rm -f  ${D}var/lib/asterisk/sounds/demo-*
		rm -f  ${D}var/lib/asterisk/agi-bin/*
	else
		einfo "Sample files have been installed"
		keepdir /var/spool/asterisk/voicemail/default/1234/INBOX
	fi

	# move sample configuration files to doc directory 
	if is_ast10update; then
		einfo "Updating from old (pre-1.2) asterisk version, new configuration files have been installed"
		einfo "into ${ROOT}etc/asterisk, use etc-update or dispatch-conf to update them"
	elif has_version "net-misc/asterisk"; then
		einfo "Configuration samples have been moved to: $ROOT/usr/share/doc/${PF}/conf"
		insinto /usr/share/doc/${PF}/conf
		doins ${D}etc/asterisk/*.conf* /usr/share/doc/${PF}/conf
		rm -f ${D}etc/asterisk/*.conf* 2>/dev/null
	fi

	# don't delete these directories, even if they are empty
	for x in voicemail meetme system dictate monitor tmp; do
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

	newinitd ${FILESDIR}/1.2.0/asterisk.rc6 asterisk
	newconfd ${FILESDIR}/1.2.0/asterisk.confd asterisk

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

	# install asterisk-updater
	dosbin ${FILESDIR}/1.2.0/asterisk-updater
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
	# Warning about 1.0 -> 1.2 changes...
	#
	if is_ast10update; then
		ewarn ""
		ewarn "- Please read ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.gz before continuing"
		ewarn ""
	fi

	if is_astupdate; then
		ewarn ""
		ewarn " - The initgroups patch has been dropped, please update your"
		ewarn "   \"conf.d/asterisk\" and \"init.d/asterisk\" file!"
		ewarn ""
	fi

#	if use t38; then
#		ewarn "********************** Experimental Feature **************************"
#		ewarn "Please note that T.38 pass-through support is experimental and may not"
#		ewarn "be included in newer versions!"
#		echo
#	fi
	if use genericjb; then
		ewarn "********************** Experimental Feature **************************"
		ewarn "Please note that generic jitterbuffer support is experimental and may not"
		ewarn "be included in newer versions!"
		echo
	fi

	# scan for old modules
	if is_ast10update; then
		einfo "Asterisk has been updated from pre-1.2.x, scanning for old modules"
		scan_modules
	fi
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
