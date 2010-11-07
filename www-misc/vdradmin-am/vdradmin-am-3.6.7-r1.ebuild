# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/vdradmin-am/vdradmin-am-3.6.7-r1.ebuild,v 1.2 2010/11/07 21:43:12 billie Exp $

EAPI=2

inherit eutils ssl-cert

DESCRIPTION="WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://andreas.vdr-developer.org/vdradmin-am/index.html"
SRC_URI="http://andreas.vdr-developer.org/download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 ssl +vdr"

DEPEND="dev-lang/perl
	dev-perl/Template-Toolkit
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/Locale-gettext
	virtual/perl-IO-Compress
	ipv6? ( dev-perl/IO-Socket-INET6 )
	ssl? ( dev-perl/IO-Socket-SSL )
	vdr? ( media-video/vdr )
	perl-core/libnet
	dev-perl/Authen-SASL
	dev-perl/Digest-HMAC"
RDEPEND="${DEPEND}"

ETC_DIR=/etc/vdradmin
CERTS_DIR=/etc/vdradmin/certs
LIB_DIR=/usr/share/vdradmin
CACHE_DIR=/var/cache/vdradmin
VDRADMIN_USER=vdradmin
VDRADMIN_GROUP=vdradmin

create_ssl_cert() {
	# The ssl-cert eclass is not flexible enough so do some steps manually
	SSL_ORGANIZATION="${SSL_ORGANIZATION:-vdradmin-am}"
	SSL_COMMONNAME="${SSL_COMMONNAME:-`hostname -f`}"

	gen_cnf || return 1

	gen_key 1 || return 1
	gen_csr 1 || return 1
	gen_crt 1 || return 1
}

pkg_setup() {
	enewgroup ${VDRADMIN_GROUP}
	enewuser ${VDRADMIN_USER} -1 /bin/bash ${CACHE_DIR} ${VDRADMIN_GROUP}

	if ! use vdr; then
		elog
		elog "You can run ${PN} outside a vdr install. For minimal"
		elog "functionality you need access to the epg.data file of your VDR."
	fi
}

src_prepare() {
	sed -i vdradmind.pl \
		-e "/COMPILE_DIR/s-/tmp-${CACHE_DIR}-" \
		-e "s-FILES_IN_SYSTEM    = 0;-FILES_IN_SYSTEM    = 1;-g" || die
}

src_install() {
	newinitd "${FILESDIR}"/vdradmin-${PV}.init vdradmin || die
	newconfd "${FILESDIR}"/vdradmin-3.6.6.conf vdradmin || die

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/vdradmin-3.6.6.logrotate vdradmin || die

	newbin vdradmind.pl vdradmind || die

	insinto ${LIB_DIR}/template
	doins -r "${S}"/template/* || die

	insinto ${LIB_DIR}/lib/Template/Plugin
	doins -r "${S}"/lib/Template/Plugin/JavaScript.pm || die

	insinto /usr/share/locale/
	doins -r "${S}"/locale/* || die

	newman vdradmind.pl.1 vdradmind.8 || die

	dodoc CREDITS HISTORY INSTALL README* REQUIREMENTS FAQ ChangeLog || die
	docinto contrib
	dodoc "${S}"/contrib/* || die

	diropts "-m755 -o ${VDRADMIN_USER} -g ${VDRADMIN_GROUP}"
	keepdir ${ETC_DIR}
	use ssl && keepdir ${CERTS_DIR}
}

pkg_preinst() {
	if [[ -f "${ROOT}"${ETC_DIR}/vdradmind.conf ]]; then
		cp "${ROOT}"${ETC_DIR}/vdradmind.conf "${D}"${ETC_DIR}/vdradmind.conf || die
	else
		elog
		elog "Creating a new config-file."
		echo

		cat <<-EOF > "${D}"${ETC_DIR}/vdradmind.conf
			VDRCONFDIR = "${ROOT%/}"/etc/vdr
			VIDEODIR = "${ROOT%/}"/var/vdr/video
			EPG_FILENAME = "${ROOT%/}"/var/vdr/video/epg.data
			EPGIMAGES = "${ROOT%/}"/var/vdr/video/epgimages
			PASSWORD = gentoo-vdr
			USERNAME = gentoo-vdr
		EOF
		# Feed it with newlines
		yes "" \
			| "${D}"/usr/bin/vdradmind --cfgdir "${D}"${ETC_DIR} --config \
			|sed -e 's/: /: \n/g'

		[[ ${PIPESTATUS[1]} == "0" ]] || die "Failed to create initial configuration."

		elog
		elog "Created default user/password: gentoo-vdr/gentoo-vdr"
		elog
		elog "You can run \"emerge --config ${PN}\" if the default-values"
		elog "do not match your installation or change them in the Setup-Menu"
		elog "of the Web-Interface."
	fi

	chmod 0644 "${D}"${ETC_DIR}/vdradmind.conf || die
	chown ${VDRADMIN_USER}:${VDRADMIN_GROUP} "${D}"${ETC_DIR}/vdradmind.conf || die
}

pkg_postinst() {
	if use ipv6; then
		elog
		elog "To make use of the ipv6 protocol"
		elog "you need to enable it in ${ROOT%/}/etc/conf.d/vdradmin"
	fi

	if use ssl; then
		elog
		elog "To use ssl connection to your vdr"
		elog "you need to enable it in ${ROOT%/}/etc/conf.d/vdradmin"

		create_ssl_cert
		local base=$(get_base 1)
		install -D -m 0400 -o ${VDRADMIN_USER} -g ${VDRADMIN_GROUP} "${base}".key "${ROOT}"${CERTS_DIR}/server-key.pem || die
		install -D -m 0444 -o ${VDRADMIN_USER} -g ${VDRADMIN_GROUP} "${base}".crt "${ROOT}"${CERTS_DIR}/server-cert.pem || die
	fi

	elog
	elog "To extend ${PN} you can emerge"
	elog ">=media-plugins/vdr-epgsearch-0.9.25 to search the EPG,"
	elog "media-plugins/vdr-streamdev for livetv streaming and/or"
	elog "media-video/vdr with USE=\"liemikuutio\" to rename recordings"
	elog "on the machine running the VDR you connect to with ${PN}."
}

pkg_postrm() {
	rm -f "${ROOT}"${CERTS_DIR}/server-{cert,key}.pem
	rmdir --ignore-fail-on-non-empty "${ROOT}"${CERTS_DIR} \
		"${ROOT}"${ETC_DIR}
}

pkg_config() {
	"${ROOT}"/usr/bin/vdradmind -c
}
