# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/murmur/murmur-1.2.3.ebuild,v 1.3 2012/05/05 08:43:08 mgorny Exp $

EAPI="2"

inherit eutils qt4-r2

MY_P="${PN/murmur/mumble}-${PV/_/~}"

DESCRIPTION="Mumble is an open source, low-latency, high quality voice chat software"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/mumble/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+dbus debug +ice pch zeroconf"

RDEPEND=">=dev-libs/openssl-1.0.0b
	>=dev-libs/protobuf-2.2.0
	sys-apps/lsb-release
	>=sys-libs/libcap-2.15
	x11-libs/qt-core:4[ssl]
	|| ( x11-libs/qt-sql:4[sqlite] x11-libs/qt-sql:4[mysql] )
	x11-libs/qt-xmlpatterns:4
	dbus? ( x11-libs/qt-dbus:4 )
	ice? ( dev-libs/Ice )
	zeroconf? ( || ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder ) )"

DEPEND="${RDEPEND}
	>=dev-libs/boost-1.41.0
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup murmur
	enewuser murmur -1 -1 /var/lib/murmur murmur
}

src_prepare() {
	sed -i \
		-e 's:mumble-server:murmur:g' \
		"${S}"/scripts/murmur.conf \
		"${S}"/scripts/murmur.ini.system \
		|| die "sed failed."
}

src_configure() {
	local conf_add
	use dbus || conf_add="${conf_add} no-dbus"
	use debug && conf_add="${conf_add} symbols debug" || conf_add="${conf_add} release"
	use ice || conf_add="${conf_add} no-ice"
	use pch || conf_add="${conf_add} no-pch"
	use zeroconf || conf_add="${conf_add} no-bonjour"

	eqmake4 main.pro -recursive \
		CONFIG+="${conf_add} \
			no-client" \
		|| die "eqmake4 failed."
}

src_compile() {
	# parallel make workaround, upstream bug #3190498
	emake -j1 || die "emake failed."
}

src_install() {
	dodoc README CHANGES || die "Installing docs failed."

	docinto scripts
	dodoc scripts/*.php scripts/*.pl || die "Installing docs failed."

	local dir
	if use debug; then
		dir=debug
	else
		dir=release
	fi

	dobin "${dir}"/murmurd || die "Installing murmurd binary failed."

	insinto /etc/murmur/
	newins scripts/murmur.ini.system murmur.ini || die "Installing murmur.ini configuration file failed."

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/murmur.logrotate murmur || die "Installing murmur logrotate file failed."

	insinto /etc/dbus-1/system.d/
	doins scripts/murmur.conf || die "Installing murmur.conf dbus configuration file failed."

	newinitd "${FILESDIR}"/murmur.initd murmur || die "Installing murmur init.d file failed."
	newconfd "${FILESDIR}"/murmur.confd murmur || die "Installing murmur conf.d file failed."

	keepdir /var/lib/murmur /var/run/murmur /var/log/murmur
	fowners -R murmur /var/lib/murmur /var/run/murmur /var/log/murmur || die "fowners failed."
	fperms 750 /var/lib/murmur /var/run/murmur /var/log/murmur || die "fperms failed."

	doman man/murmurd.1 || die "Installing murmur manpage failed."
}

pkg_postinst() {
	echo
	elog "Useful scripts are located in /usr/share/doc/${PF}/scripts."
	elog "Please execute:"
	elog "murmurd -ini /etc/murmur/murmur.ini -supw <pw>"
	elog "chown murmur:murmur /var/lib/murmur/murmur.sqlite"
	elog "to set the build-in 'SuperUser' password before starting murmur."
	elog "Please restart dbus before starting murmur, or else dbus"
	elog "registration will fail."
	echo
}
