# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.6.1.0.ebuild,v 1.1 2009/05/11 13:56:42 chainsaw Exp $

EAPI=1
inherit eutils autotools

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/asterisk/releases/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="alsa +caps curl dahdi debug freetds h323 iconv imap jabber ldap keepsrc misdn newt nosamples odbc oss postgres radius snmp span speex ssl sqlite static vorbis"

RDEPEND="virtual/libc
	sys-libs/ncurses
	dev-libs/popt
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	caps? ( sys-libs/libcap )
	curl? ( net-misc/curl )
	dahdi? ( >=net-libs/libpri-1.4.7
		net-misc/dahdi-tools )
	freetds? ( dev-db/freetds )
	h323? ( dev-libs/pwlib
		net-libs/openh323 )
	iconv? ( virtual/libiconv )
	imap? ( virtual/imap-c-client )
	jabber? ( dev-libs/iksemel )
	ldap?	( net-nds/openldap )
	misdn? ( net-dialup/misdnuser )
	newt? ( dev-libs/newt )
	odbc? ( dev-db/unixODBC )
	postgres? ( virtual/postgresql-base )
	radius? ( net-dialup/radiusclient-ng )
	snmp? ( net-analyzer/net-snmp )
	span? ( media-libs/spandsp )
	speex? ( media-libs/speex )
	sqlite? ( dev-db/sqlite )
	ssl? ( dev-libs/openssl )
	vorbis? ( media-libs/libvorbis )"

DEPEND="${RDEPEND}
	!<net-misc/asterisk-addons-1.6"

S="${WORKDIR}/${MY_P}"

#
# shortcuts
#

# update from asterisk-1.0.x
is_ast10update() {
	return $(has_version "=net-misc/asterisk-1.0*")
}

# update from asterisk-1.2.x
is_ast12update() {
	return $(has_version "=net-misc/asterisk-1.2*")
}

# update from asterisk 1.4.x
is_ast14update() {
	return $(has_version "=net-misc/asterisk-1.4*")
}

# update in the asterisk-1.6.x line
is_astupdate() {
	if ! is_ast10update && ! is_ast12update && !is_ast14update; then
		return $(has_version "<net-misc/asterisk-${PV}")
	fi
	return 0
}

get_available_modules() {
	local modules mod x

	# build list of available modules...
	for x in app cdr codec format func pbx res; do

		for mod in $(find "${S}" -type f -name "${x}_*.c*" -print)
		do
			modules="${modules} $(basename ${mod/%.c*})"
		done
	done

	echo "${modules}"
}

pkg_setup() {
	local checkfailed=0 waitaftermsg=0

	if is_ast10update || is_ast12update || is_ast14update ; then
		ewarn "      Asterisk UPGRADE Warning"
		ewarn ""
		ewarn "- Please read "${ROOT}"usr/share/doc/${PF}/UPGRADE.txt.bz2 after the installation!"
		ewarn ""
		ewarn "      Asterisk UPGRADE Warning"
		echo
		waitaftermsg=1
	fi

	if [[ $waitaftermsg -eq 1 ]]; then
		einfo "Press Ctrl+C to abort"
		echo
		ebeep 10
	fi

	#
	# Regular checks
	#
	einfo "Running some pre-flight checks..."
	echo

	# imap requires ssl if imap-c-client was built with ssl,
	# conversely if ssl and imap are both on then imap-c-client needs ssl
	if use imap; then
		if use ssl && ! built_with_use virtual/imap-c-client ssl; then
			eerror
			eerror "IMAP with SSL requested, but your IMAP C-Client libraries"
			eerror "are built without SSL!"
			eerror
			die "Please recompile the IMAP C-Client libraries with SSL support enabled"
		elif ! use ssl && built_with_use virtual/imap-c-client ssl; then
			eerror
			eerror "IMAP without SSL requested, but your IMAP C-Client"
			eerror "libraries are built with SSL!"
			eerror
			die "Please recompile the IMAP C-Client libraries without SSL support enabled"
		fi
	fi

	if [[ -n "${ASTERISK_MODULES}" ]] ; then
		ewarn "You are overriding ASTERISK_MODULES. We will assume you know what you are doing. There is no support for this option, try without if you see breakage."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#
	# comment about h323 issues
	#
	if use h323 ; then
		ewarn "h323 useflag: It is known that the h323 module doesn't compile
		the \"normal\" way: For a workaround, asterisk will be built two times
		without cleaning the build dir."
	fi

	#
	# put pid file(s) into /var/run/asterisk
	#
	epatch "${FILESDIR}"/1.6.1/${PN}-1.6.1-var_rundir.patch || die "patch failed"

	#
	# fix gsm codec cflags (e.g. i586 core epias) and disable
	# assembler optimizations
	#
	epatch "${FILESDIR}"/1.6.1/${PN}-1.6.1-gsm-pic.patch || die "patch failed"

	#
	# add missing LIBS for uclibc
	#
	epatch "${FILESDIR}"/1.6.1/${PN}-1.6.1-uclibc.patch  || die "patch failed"

	#
	# try to tame the custom build system a little so make likes it better
	# patch credit: Diego E. 'Flameeyes' Pettenò <flameeyes@entoo.org>
	#
	epatch "${FILESDIR}"/1.6.1/asterisk-1.6.1-parallelmake.patch || die "patch failed"

	#
	# do not try to pass libraries in ldflags but use libs properly
	# keeps NET-SNMP configure test from failing horribly on --as-needed
	# http://bugs.digium.com/view.php?id=14671
	#
	epatch "${FILESDIR}"/1.6.1/asterisk-1.6.1-toolcheck-libs-not-ldflags.patch || die "patch failed"

	#
	# link UW-IMAP with Kerberos5 if necessary
	#
	epatch "${FILESDIR}"/1.6.1/asterisk-1.6.1-imap-kerberos.patch || die "patch failed"

	AT_M4DIR=autoconf eautoreconf

	# parse modules list
	if [[ -n "${ASTERISK_MODULES}" ]]; then
		local x modules="$(get_available_modules)"

		einfo "Custom list of modules specified, checking..."

		use debug && {
			einfo "Available modules: ${modules}"
			einfo " Selected modules: ${ASTERISK_MODULES}"
		}

		for x in ${ASTERISK_MODULES}; do
			if [[ "${x}" = "-*" ]]; then
				MODULES_LIST=""
			else
				if has ${x} ${modules}
				then
					MODULES_LIST="${MODULES_LIST} ${x}"
				else
					eerror "Unknown module: ${x}"
				fi
			fi
		done

		export MODULES_LIST
	fi
}

src_compile() {
	#
	# start with configure
	#
	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		--with-gsm=internal \
		--with-popt \
		--with-z \
		$(use_with alsa asound) \
		$(use_with caps cap) \
		$(use_with curl) \
		$(use_with dahdi pri) \
		$(use_with dahdi tonezone) \
		$(use_with dahdi) \
		$(use_with freetds tds) \
		$(use_with h323 h323 "/usr/share/openh323") \
		$(use_with h323 pwlib "/usr/share/pwlib") \
		$(use_with iconv) \
		$(use_with imap) \
		$(use_with jabber iksemel) \
		$(use_with misdn isdnnet) \
		$(use_with misdn suppserv) \
		$(use_with misdn) \
		$(use_with newt) \
		$(use_with odbc) \
		$(use_with oss) \
		$(use_with postgres) \
		$(use_with radius) \
		$(use_with snmp netsnmp) \
		$(use_with span spandsp) \
		$(use_with speex) \
		$(use_with speex speexdsp) \
		$(use_with sqlite sqlite3) \
		$(use_with ssl crypto) \
		$(use_with ssl) \
		$(use_with vorbis ogg) \
		$(use_with vorbis) || die "econf failed"

	#
	# custom module filter
	# run menuselect to evaluate the list of modules
	# and rewrite the list afterwards
	#
	if [[ -n "${MODULES_LIST}" ]]
	then
		local mod category tmp_list failed_list

		###
		# run menuselect

		emake menuselect.makeopts || die "emake menuselect.makeopts failed"

		###
		# get list of modules with failed dependencies

		failed_list="$(awk -F= '/^MENUSELECT_DEPSFAILED=/{ print $3 }' menuselect.makeopts)"

		###
		# traverse our list of modules

		for category in app cdr codec format func pbx res; do
			tmp_list=""

			# search list of modules for matching ones first...
			for mod in ${MODULES_LIST}; do
				# module is from current category?
				if [[ "${mod/%_*}" = "${category}" ]]
				then
					# check menuselect thinks the dependencies are met
					if has ${mod} ${failed_list}
					then
						eerror "${mod}: dependencies required to build this module are not met, NOT BUILDING!"
					else
						tmp_list="${tmp_list} ${mod}"
					fi
				fi
			done

			use debug && echo "${category} tmp: ${tmp_list}"

			# replace the module list for $category with our custom one
			if [[ -n "${tmp_list}" ]]
			then
				category="$(echo ${category} | tr '[:lower:]' '[:upper:]')"
				sed -i -e "s:^\(MENUSELECT_${category}S?\):\1=${tmp_list}:" \
					menuselect.makeopts || die "failed to set list of ${category} applications"
			fi
		done
	fi

	#
	# fasten your seatbelts (and start praying)
	#
	if use h323 ; then
		# emake one time to get h323 to make.... yea not "clean" but works
		emake
	fi

	emake || die "emake failed"
}

src_install() {
	# setup directory structure
	#
	mkdir -p "${D}"usr/lib/pkgconfig

	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" samples || die "emake samples failed"

	# remove installed sample files if nosamples flag is set
	if use nosamples; then
		einfo "Skipping installation of sample files..."
		rm -f  "${D}"var/lib/asterisk/mohmp3/*
		rm -f  "${D}"var/lib/asterisk/sounds/demo-*
		rm -f  "${D}"var/lib/asterisk/agi-bin/*
	else
		einfo "Sample files have been installed"
	fi
	rm -rf "${D}"var/spool/asterisk/voicemail/default

	# move sample configuration files to doc directory
	if is_ast10update || is_ast12update || is_ast14update; then
		einfo "Updating from old (pre-1.6) asterisk version, new configuration files have been installed"
		einfo "into "${ROOT}"etc/asterisk, use etc-update or dispatch-conf to update them"
	fi

	einfo "Configuration samples have been moved to: "${ROOT}"/usr/share/doc/${PF}/conf"
	insinto /usr/share/doc/${PF}/conf
	doins "${D}"etc/asterisk/*.conf*

	# keep directories
	keepdir /var/spool/asterisk/{system,tmp,meetme,monitor,dictate,voicemail}
	keepdir /var/log/asterisk/{cdr-csv,cdr-custom}

	newinitd "${FILESDIR}"/1.6.0/asterisk.rc6 asterisk
	newconfd "${FILESDIR}"/1.6.0/asterisk.confd asterisk

	# some people like to keep the sources around for custom patching
	# copy the whole source tree to /usr/src/asterisk-${PVF} and run make clean there
	if use keepsrc
	then
		einfo "keepsrc useflag enabled, copying source..."
		dodir /usr/src

		cp -dPR "${S}" "${D}"/usr/src/${PF} || die "copying source tree failed"

		ebegin "running make clean..."
		emake -C "${D}"/usr/src/${PF} clean >/dev/null || die "make clean failed"
		eend $?

		einfo "Source files have been saved to "${ROOT}"usr/src/${PF}"
	fi

	# install the upgrade documentation
	#
	dodoc README UPGRADE* BUGS CREDITS

	# install snmp mib files
	#
	if use snmp
	then
		insinto /usr/share/snmp/mibs/
		doins doc/digium-mib.txt doc/asterisk-mib.txt
	fi
}

pkg_preinst() {
	enewgroup asterisk
	enewuser asterisk -1 -1 /var/lib/asterisk "asterisk,dialout"
}

pkg_postinst() {
	ebegin "Fixing up permissions"
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
	eend $?

	#
	# Announcements, warnings, reminders...
	#
	einfo "Asterisk has been installed"
	echo
	elog "If you want to know more about asterisk, visit these sites:"
	elog "http://www.asteriskdocs.org/"
	elog "http://www.voip-info.org/wiki-Asterisk"
	echo
	elog "http://www.automated.it/guidetoasterisk.htm"
	echo
	elog "Gentoo VoIP IRC Channel:"
	elog "#gentoo-voip @ irc.freenode.net"
	echo
	echo

	#
	# Warning about 1.x -> 1.6 changes...
	#
	if is_ast10update || is_ast12update || is_ast14update; then
		ewarn ""
		ewarn "- Please read "${ROOT}"usr/share/doc/${PF}/UPGRADE.txt.bz2 before continuing"
		ewarn ""
	fi
}

pkg_config() {
	einfo "Do you want to reset file permissions and ownerships (y/N)?"

	read tmp
	tmp="$(echo $tmp | tr '[:upper:]' '[:lower:]')"

	if [[ "$tmp" = "y" ]] ||\
		[[ "$tmp" = "yes" ]]
	then
		einfo "Resetting permissions to defaults..."

		for x in spool run lib log; do
			chown -R asterisk:asterisk "${ROOT}"var/${x}/asterisk
			chmod -R u=rwX,g=rwX,o=    "${ROOT}"var/${x}/asterisk
		done

		chown -R root:asterisk  "${ROOT}"etc/asterisk
		chmod -R u=rwX,g=rwX,o= "${ROOT}"etc/asterisk

		einfo "done"
	else
		einfo "skipping"
	fi
}
