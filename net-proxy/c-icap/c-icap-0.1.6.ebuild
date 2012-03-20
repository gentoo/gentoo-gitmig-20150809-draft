# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/c-icap/c-icap-0.1.6.ebuild,v 1.4 2012/03/20 14:48:44 jer Exp $

EAPI=2

inherit eutils multilib flag-o-matic autotools

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="C Implementation of an ICAP server"
HOMEPAGE="http://c-icap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="berkdb ipv6 ldap"

RDEPEND="berkdb? ( sys-libs/db )
	ldap? ( net-nds/openldap )
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1.3-asneeded.patch"
	epatch "${FILESDIR}/${PN}-0.1.3-implicit.patch"
	epatch "${FILESDIR}/${PN}-0.1.3+db-5.0.patch"
	epatch "${FILESDIR}/${PN}-0.1.4-crosscompile.patch"
	epatch "${FILESDIR}/${PN}-0.1.6-implicit.patch"
	eautoreconf
}

src_configure() {
	# some void *** pointers get casted around and can be troublesome to
	# fix properly.
	append-flags -fno-strict-aliasing

	econf \
		--sysconfdir=/etc/${PN} \
		--disable-dependency-tracking \
		--disable-maintainer-mode \
		--disable-static \
		--enable-large-files \
		$(use_enable ipv6) \
		$(use_with berkdb bdb) \
		$(use_with ldap)
}

src_compile() {
	emake LOGDIR="/var/log" || die
}

src_install() {
	emake \
		LOGDIR="/var/log" \
		DESTDIR="${D}" install || die

	find "${D}" -name '*.la' -delete || die

	# Move the daemon out of the way
	dodir /usr/libexec
	mv "${D}"/usr/bin/c-icap "${D}"/usr/libexec || die

	# Remove the default configuration files since we have etc-update to
	# take care of it for us.
	rm "${D}"/etc/${PN}/c-icap.*.default || die

	# Fix the configuration file; for some reason it's a bit messy
	# around.
	sed -i \
		-e 's:/usr/var/:/var/:g' \
		-e 's:/var/log/:/var/log/c-icap/:g' \
		-e 's:/usr/etc/:/etc/c-icap/:g' \
		-e 's:/usr/local/c-icap/etc/:/etc/c-icap/:g' \
		-e 's:/usr/lib/:/usr/'$(get_libdir)'/:g' \
		"${D}"/etc/${PN}/c-icap.conf \
		|| die

	dodoc AUTHORS README TODO ChangeLog || die

	newinitd "${FILESDIR}/${PN}.init" ${PN} || die
	keepdir /var/log/c-icap || die

	insopts -m0644
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}
}

pkg_postinst() {
	elog "To enable Squid to call the ICAP modules from a local server you should set"
	elog "the following in your squid.conf:"
	elog ""
	elog "    icap_enable on"
	elog ""
	elog "    # not strictly needed, but some modules might make use of these"
	elog "    icap_send_client_ip on"
	elog "    icap_send_client_username on"
	elog ""
	elog "    icap_service service_req reqmod_precache bypass=1 icap://localhost:1344/service"
	elog "    adaptation_access service_req allow all"
	elog ""
	elog "    icap_service service_resp respmod_precache bypass=0 icap://localhost:1344/service"
	elog "    adaptation_access service_resp allow all"
	elog ""
	elog "You obviously will have to replace \"service\" with the actual ICAP service to"
	elog "use."
}
