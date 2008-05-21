# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.2.21.1-r1.ebuild,v 1.6 2008/05/21 19:00:02 dev-zero Exp $

inherit eutils multilib toolchain-funcs

IUSE="alsa bri curl debug doc gtk h323 hardened lowmem mmx \
	nosamples odbc osp postgres pri speex sqlite ssl zaptel \
	elibc_uclibc"

BRI_VERSION="0.3.0-PRE-1y-h"
AST_PATCHES="1.2.21.1-patches-1.1"
JB_PATCHES="1.2.11-jb"

MY_P="${P/_p/.}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/releases/${MY_P}.tar.gz
	 http://www.netdomination.org/pub/asterisk/${PN}-${AST_PATCHES}.tar.bz2
	 mirror://gentoo/${PN}-${AST_PATCHES}.tar.bz2
	 bri? ( mirror://gentoo/${MY_P}-bristuff-${BRI_VERSION}.diff.bz2
		http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"

S="${WORKDIR}/${MY_P}"
S_BRI="${WORKDIR}/bristuff-${BRI_VERSION}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ppc sparc x86"

RDEPEND="dev-libs/newt
	media-sound/sox
	ssl? ( dev-libs/openssl )
	gtk? ( =x11-libs/gtk+-1.2* )
	pri? ( >=net-libs/libpri-1.2.5 )
	h323? ( >=dev-libs/pwlib-1.8.3
		>=net-libs/openh323-1.15.0 )
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	odbc? ( dev-db/unixODBC )
	speex? ( media-libs/speex )
	sqlite? ( <dev-db/sqlite-3.0.0 )
	zaptel? ( >=net-misc/zaptel-1.2.16 )
	postgres? ( virtual/postgresql-server )
	osp? ( >=net-libs/osptoolkit-3.3.4 )
	bri? (  >=net-libs/libpri-1.2.5
		>=net-misc/zaptel-1.2.18 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	doc? ( app-doc/doxygen )
	virtual/logger"

#asterisk uses special mpg123 functions and does not work with mpeg321, bug #42703
PDEPEND="|| ( media-sound/mpg123 net-misc/asterisk-addons )"

QA_TEXTRELS_x86="usr/lib/asterisk/modules/codec_gsm.so"
QA_EXECSTACK_x86="usr/lib/asterisk/modules/codec_gsm.so"

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

	for x in $(ls -1 "${ROOT}"usr/$(get_libdir)/asterisk/modules/*.so); do
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

	if use bri; then
		if ! built_with_use net-libs/libpri bri; then
			die "net-libs/libpri must be rebuilt ith USE=bri."
		fi
	elif use pri; then
		if built_with_use net-libs/libpri bri; then
			die "net-libs/libpri must be rebuilt without USE=bri."
		fi
	fi

	#
	# Regular checks
	#
	einfo "Running some pre-flight checks..."
	echo

}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#
	# gentoo patchset
	#
	for x in $(grep -v "^#\| \+" "${WORKDIR}"/patches/patches.list); do
		epatch "${WORKDIR}"/patches/${x}
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
		sed -i -e 's:^#\(NOCRYPTO=yes\):\1:' \
			-e '/^LIBS+=-lssl/d' Makefile || die
	fi

	epatch "${FILESDIR}"/1.2.0/asterisk-1.2.21.1-h323-dumb-makefile.diff

	#
	# uclibc patch
	#
	if use elibc_uclibc; then
		einfo "Patching asterisk for uclibc..."
		epatch "${FILESDIR}"/1.0.0/${PN}-1.0.5-uclibc-dns.diff
		epatch "${FILESDIR}"/1.2.0/${PN}-1.2.1-uclibc-getloadavg.diff
	fi

	#
	# BRI patches
	#
	if use bri; then
		einfo "Patching asterisk w/ BRI stuff"

		epatch "${WORKDIR}"/${MY_P}-bristuff-${BRI_VERSION}.diff
		#epatch "${S_BRI}"/patches/asterisk.patch
	fi

	#
	# Disable AEL, security bug #171884
	# Re-enable at your own risk (no USE since it can be critical)
	#
	sed -i -e 's/pbx_ael.so//' pbx/Makefile || die

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
		CC=$(tc-getCC) \
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
		make -C "${S_BRI}"/ISDNguard
}

src_install() {

	# install asterisk
	make DESTDIR="${D}" ASTLIBDIR="\$(INSTALL_PREFIX)/usr/$(get_libdir)/asterisk" install || die "Make install failed"
	make DESTDIR="${D}" ASTLIBDIR="\$(INSTALL_PREFIX)/usr/$(get_libdir)/asterisk" samples || die "Failed to create sample files"

	# remove bristuff capi
	use bri && \
		rm -f "${D}"usr/$(get_libdir)/asterisk/modules/{app,chan}_capi*.so 2>/dev/null

	# remove installed sample files if nosamples flag is set
	if use nosamples; then
		einfo "Skipping installation of sample files..."
		rm -rf "${D}"var/spool/asterisk/voicemail/default
		rm -f  "${D}"var/lib/asterisk/mohmp3/*
		rm -f  "${D}"var/lib/asterisk/sounds/demo-*
		rm -f  "${D}"var/lib/asterisk/agi-bin/*
	else
		einfo "Sample files have been installed"
		keepdir /var/spool/asterisk/voicemail/default/1234/INBOX
	fi

	# move sample configuration files to doc directory
	if is_ast10update; then
		elog "Updating from old (pre-1.2) asterisk version, new configuration files have been installed"
		elog "into ${ROOT}etc/asterisk, use etc-update or dispatch-conf to update them"
	elif has_version "net-misc/asterisk"; then
		elog "Configuration samples have been moved to: $ROOT/usr/share/doc/${PF}/conf"
		insinto /usr/share/doc/${PF}/conf
		doins "${D}"etc/asterisk/*.conf*
		rm -f "${D}"etc/asterisk/*.conf* 2>/dev/null
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

	# install astxs
	dobin  contrib/scripts/astxs

	newinitd "${FILESDIR}"/1.2.0/asterisk.rc6 asterisk
	newconfd "${FILESDIR}"/1.2.0/asterisk.confd asterisk

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
		cd "${S_BRI}"/ISDNguard
		dosbin ISDNguard

		docinto ISDNguard
		dodoc INSTALL.ISDNguard

		cd "${S}"
	fi

	insinto /usr/share/doc/${PF}/cgi
	doins contrib/scripts/vmail.cgi
	doins images/*.gif

	# install asterisk-updater
	dosbin "${FILESDIR}"/1.2.0/asterisk-updater

	# install asterisk.h, a lot of external modules need this
	insinto /usr/include/asterisk
	doins   include/asterisk.h

	# make sure misdn/capi stuff is not installed, provided by asterisk-chan_..
	rm -f "${D}"/etc/asterisk/misdn.conf "${D}"/usr/lib/asterisk/modules/chan_misdn.so \
		"${D}"/usr/share/doc/${PF}/{conf/misdn.conf,configs/misdn.conf.sample.gz,README.misdn.gz}
	rm -f "${D}"/usr/include/asterisk/chan_capi{,_app}.h \
		"${D}"/usr/share/doc/${PF}/{conf/capi.conf,configs/capi.conf.sample.gz}
}

pkg_preinst() {
	enewgroup asterisk
	enewuser asterisk -1 -1 /var/lib/asterisk asterisk
}

pkg_postinst() {
	einfo "Fixing permissions"
	chown -R asterisk:asterisk "${ROOT}"var/log/asterisk
	chmod -R u=rwX,g=rX,o=     "${ROOT}"var/log/asterisk

	for x in lib run spool; do
		chown -R asterisk:asterisk "${ROOT}"var/${x}/asterisk
		chmod -R u=rwX,g=rwX,o=    "${ROOT}"var/${x}/asterisk
	done

	chown asterisk:asterisk "${ROOT}"etc/asterisk/
	chown asterisk:asterisk "${ROOT}"etc/asterisk/*.adsi
	chown asterisk:asterisk "${ROOT}"etc/asterisk/extensions.ael
	chmod u=rwX,g=rwX,o= "${ROOT}"etc/asterisk/
	chmod u=rwX,g=rwX,o= "${ROOT}"etc/asterisk/*.adsi
	chmod u=rwX,g=rwX,o= "${ROOT}"etc/asterisk/extensions.ael
	echo

	#
	# Announcements, warnings, reminders...
	#
	einfo "Asterisk has been installed"
	einfo ""
	elog "If you want to know more about asterisk, visit these sites:"
	elog "http://www.asteriskdocs.org/"
	elog "http://www.voip-info.org/wiki-Asterisk"
	elog
	elog "http://www.automated.it/guidetoasterisk.htm"
	elog
	elog "Gentoo VoIP IRC Channel:"
	elog "#gentoo-voip @ irc.freenode.net"
	elog
	elog "Please note that AEL is no longer built because of security bugs"
	elog "See http://bugs.gentoo.org/show_bug.cgi?id=171884"
	elog
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
			chown -R asterisk:asterisk "${ROOT}"var/${x}/asterisk
			chmod -R u=rwX,g=rX,o=     "${ROOT}"var/${x}/asterisk
		done

		chown -R root:asterisk "${ROOT}"etc/asterisk
		chmod -R u=rwX,g=rX,o= "${ROOT}"etc/asterisk

		einfo "done"
	else
		einfo "skipping"
	fi
}
