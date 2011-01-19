# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.4.39.1.ebuild,v 1.2 2011/01/19 17:25:39 c1pher Exp $

EAPI=3
inherit autotools base eutils flag-o-matic linux-info multilib

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.asterisk.org/pub/telephony/asterisk/releases/${MY_P}.tar.gz
	 mirror://gentoo/gentoo-ast14-patchset-0.1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa +caps dahdi debug doc freetds imap jabber keepsrc misdn newt +samples odbc oss postgres radius snmp speex ssl sqlite static vanilla vorbis"

EPATCH_SUFFIX="patch"
PATCHES=( "${WORKDIR}/ast14-patchset" )

RDEPEND="sys-libs/ncurses
	dev-libs/popt
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	caps? ( sys-libs/libcap )
	dahdi? ( >=net-libs/libpri-1.4.7
		net-misc/dahdi-tools )
	freetds? ( dev-db/freetds )
	imap? ( >=net-libs/c-client-2007[ssl=] )
	jabber? ( dev-libs/iksemel )
	misdn? ( net-dialup/misdnuser )
	newt? ( dev-libs/newt )
	odbc? ( dev-db/unixODBC )
	postgres? ( dev-db/postgresql-base )
	radius? ( net-dialup/radiusclient-ng )
	snmp? ( net-analyzer/net-snmp )
	speex? ( media-libs/speex )
	sqlite? ( dev-db/sqlite )
	ssl? ( dev-libs/openssl )
	vorbis? ( media-libs/libvorbis )"

DEPEND="${RDEPEND}
	!<net-misc/asterisk-addons-1.4
	!>=net-misc/asterisk-addons-1.6
	!net-misc/zaptel"

PDEPEND="net-misc/asterisk-core-sounds
	net-misc/asterisk-extra-sounds
	net-misc/asterisk-moh-opsound"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	CONFIG_CHECK="~!NF_CONNTRACK_SIP"
	local WARNING_NF_CONNTRACK_SIP="SIP (NAT) connection tracking is enabled. Some users
	have reported that this module dropped critical SIP packets in their deployments. You
	may want to disable it if you see such problems."
	check_extra_config

	enewgroup asterisk
	enewuser asterisk -1 -1 /var/lib/asterisk "asterisk,dialout"
}

src_prepare() {
	base_src_prepare
	AT_M4DIR=autoconf eautoreconf

	# add custom device state function (func_devstate)
	#
	# http://asterisk.org/node/48360
	# http://svncommunity.digium.com/svn/russell/func_devstate-1.4/README.txt
	#
	cp "${FILESDIR}"/1.4.0/func_devstate-r6.c "${S}"/funcs/func_devstate.c

	# Add technology-independent volume control function
	#
	cp "${FILESDIR}"/1.4.0/func_volume.c "${S}"/funcs/func_volume.c

	# Custom menuselect options are defined in this file (it may remain empty)
	#
	>"${S}"/gentoo.makeopts

	# Enable various debugging options if requested
	#
	if use debug; then
		local debug_opts="DEBUG_CHANNEL_LOCKS DEBUG_THREADS DEBUG_FD_LEAKS"
		einfo "Enabling debugging options: ${debug_opts}"
		echo "MENUSELECT_CFLAGS=${debug_opts}" >> "${S}"/gentoo.makeopts
	fi

	# Enable IMAP storage in app_voicemail if requested
	#
	use imap && echo "MENUSELECT_OPTS_app_voicemail=IMAP_STORAGE" >> "${S}"/gentoo.makeopts
}

src_configure() {
	if use debug; then
		# Tone down the compiler flags somewhat. This should be less aggressive
		# than the DONT_OPTIMIZE option whilst still producing useful results.
		#
		strip-flags
		replace-flags -O? -O0
	fi

	if use imap; then
		local imap_libs
		has_version net-libs/c-client[pam] && imap_libs="-lpam"
		has_version net-libs/c-client[ssl] && imap_libs="${imap_libs} -lssl"
		export IMAP_LIBS="${imap_libs}"
	fi

	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		--with-gsm=internal \
		--with-ncurses \
		--with-popt \
		--with-z \
		--without-curses \
		--without-h323 \
		--without-nbs \
		--without-osptk \
		--without-pwlib \
		--without-kde \
		--without-usb \
		--without-vpb \
		--without-zaptel \
		$(use_with alsa asound) \
		$(use_with caps cap) \
		$(use_with dahdi pri) \
		$(use_with dahdi tonezone) \
		$(use_with dahdi) \
		$(use_with freetds tds) \
		$(use_with imap imap system) \
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
		$(use_with speex) \
		$(use_with speex speexdsp) \
		$(use_with sqlite) \
		$(use_with ssl) \
		$(use_with vorbis ogg) \
		$(use_with vorbis) || die "econf failed"

	#
	# blank out sounds/sounds.xml file to prevent
	# asterisk from installing sounds files (we pull them in via
	# asterisk-{core,extra}-sounds and asterisk-moh-opsound.
	#
	>"${S}"/sounds/sounds.xml
}

src_compile() {
	ASTLDFLAGS="${LDFLAGS}" emake USER_MAKEOPTS="${S}"/gentoo.makeopts || die "emake failed"
}

src_install() {
	# setup directory structure
	#
	mkdir -p "${D}"usr/$(get_libdir)/pkgconfig

	emake DESTDIR="${D}" install || die "emake install failed"

	if use samples; then
		emake DESTDIR="${D}" samples || die "emake samples failed"
		for conffile in "${D}"etc/asterisk/*.*
		do
			chown asterisk:asterisk $conffile
			chmod 0660 $conffile
		done
		einfo "Sample files have been installed"
	else
		einfo "Skipping installation of sample files..."
		rm -f  "${D}"var/lib/asterisk/mohmp3/*
		rm -f  "${D}"var/lib/asterisk/sounds/demo-*
		rm -f  "${D}"var/lib/asterisk/agi-bin/*
		rm -f  "${D}"etc/asterisk/*
	fi
	rm -rf "${D}"var/spool/asterisk/voicemail/default

	# keep directories
	diropts -m 0770 -o asterisk -g asterisk
	keepdir	/etc/asterisk
	keepdir /var/lib/asterisk
	keepdir /var/run/asterisk
	keepdir /var/spool/asterisk
	keepdir /var/spool/asterisk/{system,tmp,meetme,monitor,dictate,voicemail}
	diropts -m 0750 -o asterisk -g asterisk
	keepdir /var/log/asterisk/{cdr-csv,cdr-custom}

	newinitd "${FILESDIR}"/1.4.0/asterisk.initd asterisk
	newconfd "${FILESDIR}"/1.4.0/asterisk.confd asterisk

	# some people like to keep the sources around for custom patching
	# copy the whole source tree to /usr/src/asterisk-${PVF} and run make clean there
	if use keepsrc
	then
		dodir /usr/src

		ebegin "Copying sources into /usr/src"
		cp -dPR "${S}" "${D}"/usr/src/${PF} || die "Unable to copy sources"
		eend $?

		ebegin "Cleaning source tree"
		emake -C "${D}"/usr/src/${PF} clean &>/dev/null || die "Unable to clean sources"
		eend $?

		einfo "Clean sources are available in "${ROOT}"usr/src/${PF}"
	fi

	# install the upgrade documentation
	#
	dodoc README UPGRADE* BUGS CREDITS

	# install extra documentation
	#
	if use doc
	then
		dodoc doc/*.txt
		dodoc doc/*.pdf
		dodoc doc/PEERING
		dodoc doc/CODING-GUIDELINES
		dodoc doc/tex/*.pdf
	fi

	# install snmp mib files
	#
	if use snmp
	then
		insinto /usr/share/snmp/mibs/
		doins doc/digium-mib.txt doc/asterisk-mib.txt
	fi

	# install SIP scripts; bug #300832
	#
	dodoc "${FILESDIR}/1.6.2/sip_calc_auth"
	dodoc "${FILESDIR}/1.6.2/find_call_sip_trace.sh"
	dodoc "${FILESDIR}/1.6.2/find_call_ids.sh"
	dodoc "${FILESDIR}/1.6.2/call_data.txt"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/1.4.0/asterisk.logrotate" asterisk
}

pkg_postinst() {
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
	if has_version "=net-misc/asterisk-1.2*"; then
		ewarn "Please read "${ROOT}"usr/share/doc/${PF}/UPGRADE.txt.bz2 before continuing"
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
