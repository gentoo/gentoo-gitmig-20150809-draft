# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-1.8.2.2.ebuild,v 1.1 2011/01/22 02:36:25 chainsaw Exp $

EAPI=3
inherit autotools base eutils linux-info multilib

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.asterisk.org/pub/telephony/asterisk/${MY_P}.tar.gz
	 mirror://gentoo/gentoo-asterisk-patchset-0.2.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="ais alsa bluetooth calendar +caps curl dahdi debug doc freetds gtalk h323 http iconv jabber jingle ldap lua misdn mysql newt +samples odbc osplookup oss portaudio postgres radius snmp span speex ssl sqlite sqlite3 srtp static syslog usb vorbis"

EPATCH_SUFFIX="patch"
PATCHES=( "${WORKDIR}/asterisk-patchset" )

RDEPEND="sys-libs/ncurses
	dev-libs/popt
	sys-libs/zlib
	dev-libs/libxml2
	ais? ( sys-cluster/openais )
	alsa? ( media-libs/alsa-lib )
	bluetooth? ( net-wireless/bluez )
	calendar? ( net-libs/neon
		 dev-libs/libical
		 dev-libs/iksemel )
	caps? ( sys-libs/libcap )
	curl? ( net-misc/curl )
	dahdi? ( >=net-libs/libpri-1.4.12_beta2
		net-misc/dahdi-tools )
	freetds? ( dev-db/freetds )
	gtalk? ( dev-libs/iksemel )
	h323? ( net-libs/openh323 )
	http? ( dev-libs/gmime:0 )
	iconv? ( virtual/libiconv )
	jabber? ( dev-libs/iksemel )
	jingle? ( dev-libs/iksemel )
	ldap? ( net-nds/openldap )
	lua? ( dev-lang/lua )
	misdn? ( net-dialup/misdnuser )
	mysql? ( dev-db/mysql )
	newt? ( dev-libs/newt )
	odbc? ( dev-db/unixODBC )
	osplookup? ( net-libs/osptoolkit
		dev-libs/openssl )
	portaudio? ( media-libs/portaudio )
	postgres? ( dev-db/postgresql-base )
	radius? ( net-dialup/radiusclient-ng )
	snmp? ( net-analyzer/net-snmp )
	span? ( media-libs/spandsp )
	speex? ( media-libs/speex )
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )
	srtp? ( net-libs/libsrtp )
	ssl? ( dev-libs/openssl )
	syslog? ( app-admin/syslog-ng )
	usb? ( dev-libs/libusb
		media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )"

DEPEND="${RDEPEND}
	!net-misc/asterisk-addons
	!net-misc/asterisk-chan_unistim
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
}

src_configure() {
	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		--with-gsm=internal \
		--with-popt \
		--with-z \
		$(use_with caps cap) \
		$(use_with http gmime) \
		$(use_with newt) \
		$(use_with portaudio) \
		$(use_with ssl crypto) \
		$(use_with ssl)

	#
	# blank out sounds/sounds.xml file to prevent
	# asterisk from installing sounds files (we pull them in via
	# asterisk-{core,extra}-sounds and asterisk-moh-opsound.
	#
	>"${S}"/sounds/sounds.xml

	# Compile menuselect binary for optional components
	emake menuselect.makeopts
	if use ais; then
		menuselect/menuselect --enable res_ais menuselect.makeopts
	else
		menuselect/menuselect --disable res_ais menuselect.makeopts
	fi
	if use alsa; then
		menuselect/menuselect --enable chan_alsa menuselect.makeopts
	else
		menuselect/menuselect --disable chan_alsa menuselect.makeopts
	fi
	if use bluetooth; then
		menuselect/menuselect --enable chan_mobile menuselect.makeopts
	else
		menuselect/menuselect --disable chan_mobile menuselect.makeopts
	fi
	if use calendar; then
		menuselect/menuselect --enable res_calendar menuselect.makeopts
		menuselect/menuselect --enable res_calendar_caldav menuselect.makeopts
		menuselect/menuselect --enable res_calendar_ews menuselect.makeopts
		menuselect/menuselect --enable res_calendar_exchange menuselect.makeopts
		menuselect/menuselect --enable res_calendar_icalendar menuselect.makeopts
	else
		menuselect/menuselect --disable res_calendar menuselect.makeopts
		menuselect/menuselect --disable res_calendar_caldav menuselect.makeopts
		menuselect/menuselect --disable res_calendar_ews menuselect.makeopts
		menuselect/menuselect --disable res_calendar_exchange menuselect.makeopts
		menuselect/menuselect --disable res_calendar_icalendar menuselect.makeopts
	fi
	if use curl; then
		menuselect/menuselect --enable func_curl menuselect.makeopts
		menuselect/menuselect --enable res_config_curl menuselect.makeopts
		menuselect/menuselect --enable res_curl menuselect.makeopts
	else
		menuselect/menuselect --disable func_curl menuselect.makeopts
		menuselect/menuselect --disable res_config_curl menuselect.makeopts
		menuselect/menuselect --disable res_curl menuselect.makeopts
	fi
	if use dahdi; then
		menuselect/menuselect --enable app_dahdibarge menuselect.makeopts
		menuselect/menuselect --enable app_dahdiras menuselect.makeopts
		menuselect/menuselect --enable chan_dahdi menuselect.makeopts
		menuselect/menuselect --enable codec_dahdi menuselect.makeopts
		menuselect/menuselect --enable res_timing_dahdi menuselect.makeopts
	else
		menuselect/menuselect --disable app_dahdibarge menuselect.makeopts
		menuselect/menuselect --disable app_dahdiras menuselect.makeopts
		menuselect/menuselect --disable chan_dahdi menuselect.makeopts
		menuselect/menuselect --disable codec_dahdi menuselect.makeopts
		menuselect/menuselect --disable res_timing_dahdi menuselect.makeopts
	fi
	if use freetds; then
		menuselect/menuselect --enable cdr_tds menuselect.makeopts
		menuselect/menuselect --enable cel_tds menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_tds menuselect.makeopts
		menuselect/menuselect --disable cel_tds menuselect.makeopts
	fi
	if use gtalk; then
		menuselect/menuselect --enable chan_gtalk menuselect.makeopts
	else
		menuselect/menuselect --disable chan_gtalk menuselect.makeopts
	fi
	if use h323; then
		menuselect/menuselect --enable chan_ooh323 menuselect.makeopts
	else
		menuselect/menuselect --disable chan_ooh323 menuselect.makeopts
	fi
	if use http; then
		menuselect/menuselect --enable res_http_post menuselect.makeopts
	else
		menuselect/menuselect --disable res_http_post menuselect.makeopts
	fi
	if use iconv; then
		menuselect/menuselect --enable func_iconv menuselect.makeopts
	else
		menuselect/menuselect --disable func_iconv menuselect.makeopts
	fi
	if use jabber; then
		menuselect/menuselect --enable res_jabber menuselect.makeopts
	else
		menuselect/menuselect --disable res_jabber menuselect.makeopts
	fi
	if use jingle; then
		menuselect/menuselect --enable chan_jingle menuselect.makeopts
	else
		menuselect/menuselect --disable chan_jingle menuselect.makeopts
	fi
	if use ldap; then
		menuselect/menuselect --enable res_config_ldap menuselect.makeopts
	else
		menuselect/menuselect --disable res_config_ldap menuselect.makeopts
	fi
	if use lua; then
		menuselect/menuselect --enable pbx_lua menuselect.makeopts
	else
		menuselect/menuselect --disable pbx_lua menuselect.makeopts
	fi
	if use misdn; then
		menuselect/menuselect --enable chan_misdn menuselect.makeopts
	else
		menuselect/menuselect --disable chan_misdn menuselect.makeopts
	fi
	if use mysql; then
		menuselect/menuselect --enable app_mysql menuselect.makeopts
		menuselect/menuselect --enable cdr_mysql menuselect.makeopts
		menuselect/menuselect --enable res_config_mysql menuselect.makeopts
	else
		menuselect/menuselect --disable app_mysql menuselect.makeopts
		menuselect/menuselect --disable cdr_mysql menuselect.makeopts
		menuselect/menuselect --disable res_config_mysql menuselect.makeopts
	fi
	if use odbc; then
		menuselect/menuselect --enable cdr_adaptive_odbc menuselect.makeopts
		menuselect/menuselect --enable cdr_odbc menuselect.makeopts
		menuselect/menuselect --enable cel_odbc menuselect.makeopts
		menuselect/menuselect --enable func_odbc menuselect.makeopts
		menuselect/menuselect --enable res_config_odbc menuselect.makeopts
		menuselect/menuselect --enable res_odbc menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_adaptive_odbc menuselect.makeopts
		menuselect/menuselect --disable cdr_odbc menuselect.makeopts
		menuselect/menuselect --disable cel_odbc menuselect.makeopts
		menuselect/menuselect --disable func_odbc menuselect.makeopts
		menuselect/menuselect --disable res_config_odbc menuselect.makeopts
		menuselect/menuselect --disable res_odbc menuselect.makeopts
	fi
	if use osplookup; then
		menuselect/menuselect --enable app_osplookup menuselect.makeopts
	else
		menuselect/menuselect --disable app_osplookup menuselect.makeopts
	fi
	if use oss; then
		menuselect/menuselect --enable chan_oss menuselect.makeopts
	else
		menuselect/menuselect --disable chan_oss menuselect.makeopts
	fi
	if use postgres; then
		menuselect/menuselect --enable cdr_pgsql menuselect.makeopts
		menuselect/menuselect --enable cel_pgsql menuselect.makeopts
		menuselect/menuselect --enable res_config_pgsql menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_pgsql menuselect.makeopts
		menuselect/menuselect --disable cel_pgsql menuselect.makeopts
		menuselect/menuselect --disable res_config_pgsql menuselect.makeopts
	fi
	if use radius; then
		menuselect/menuselect --enable cdr_radius menuselect.makeopts
		menuselect/menuselect --enable cel_radius menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_radius menuselect.makeopts
		menuselect/menuselect --disable cel_radius menuselect.makeopts
	fi
	if use snmp; then
		menuselect/menuselect --enable res_snmp menuselect.makeopts
	else
		menuselect/menuselect --disable res_snmp menuselect.makeopts
	fi
	if use span; then
		menuselect/menuselect --enable res_fax_spandsp menuselect.makeopts
	else
		menuselect/menuselect --disable res_fax_spandsp menuselect.makeopts
	fi
	if use speex; then
		menuselect/menuselect --enable codec_speex menuselect.makeopts
		menuselect/menuselect --enable func_speex menuselect.makeopts
	else
		menuselect/menuselect --disable codec_speex menuselect.makeopts
		menuselect/menuselect --disable func_speex menuselect.makeopts
	fi
	if use sqlite; then
		menuselect/menuselect --enable cdr_sqlite menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_sqlite menuselect.makeopts
	fi
	if use sqlite3; then
		menuselect/menuselect --enable cdr_sqlite3_custom menuselect.makeopts
		menuselect/menuselect --enable cel_sqlite3_custom menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_sqlite3_custom menuselect.makeopts
		menuselect/menuselect --disable cel_sqlite3_custom menuselect.makeopts
	fi
	if use srtp; then
		menuselect/menuselect --enable res_srtp menuselect.makeopts
	else
		menuselect/menuselect --disable res_srtp menuselect.makeopts
	fi
	if use syslog; then
		menuselect/menuselect --enable cdr_syslog menuselect.makeopts
	else
		menuselect/menuselect --disable cdr_syslog menuselect.makeopts
	fi
	if use usb; then
		menuselect/menuselect --enable chan_usbradio menuselect.makeopts
	else
		menuselect/menuselect --disable chan_usbradio menuselect.makeopts
	fi
	if use vorbis; then
		menuselect/menuselect --enable format_ogg_vorbis menuselect.makeopts
	else
		menuselect/menuselect --disable format_ogg_vorbis menuselect.makeopts
	fi
}

src_compile() {
	ASTLDFLAGS="${LDFLAGS}" emake || die "emake failed"
}

src_install() {
	mkdir -p "${D}"usr/$(get_libdir)/pkgconfig
	emake DESTDIR="${D}" -j1 installdirs || die "emake installdirs failed"
	emake DESTDIR="${D}" install || die "emake installdirs failed"

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

	newinitd "${FILESDIR}"/1.6.2/asterisk.initd2 asterisk
	newconfd "${FILESDIR}"/1.6.0/asterisk.confd asterisk

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

	# install SIP scripts; bug #300832
	#
	dodoc "${FILESDIR}/1.6.2/sip_calc_auth"
	dodoc "${FILESDIR}/1.6.2/find_call_sip_trace.sh"
	dodoc "${FILESDIR}/1.6.2/find_call_ids.sh"
	dodoc "${FILESDIR}/1.6.2/call_data.txt"

	# install logrotate snippet; bug #329281
	#
	insinto /etc/logrotate.d
	newins "${FILESDIR}/1.6.2/asterisk.logrotate3" asterisk
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
	elog "1.6 -> 1.8 changes that you may care about:"
	elog "http://svn.asterisk.org/svn/${PN}/tags/${PV}/UPGRADE.txt"
	elog "or: bzless ${ROOT}usr/share/doc/${PF}/UPGRADE.txt.bz2"
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
