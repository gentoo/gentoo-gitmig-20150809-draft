# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/murmur/murmur-1.1.6.ebuild,v 1.1 2008/10/16 22:42:35 tgurr Exp $

EAPI="2"

inherit eutils qt4

MY_PN=mumble
MY_P=${MY_PN}-${PV}

DESCRIPTION="Voice chat software for gaming written in Qt4 (server)"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug logrotate pch"

RDEPEND="dev-libs/boost
	|| ( ( x11-libs/qt-core:4[ssl]
			x11-libs/qt-sql:4
			x11-libs/qt-dbus:4 )
		( >=x11-libs/qt-4.3:4 ) )
	logrotate? ( app-admin/logrotate )
	dev-cpp/Ice"

DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	if ! has_version 'x11-libs/qt-sql[sqlite]' && ! has_version 'x11-libs/qt-sql[mysql]'; then
		eerror "You need to built x11-libs/qt-sql with USE \"sqlite\" or \"mysql\" for a database backend."
		die "No database backend selected."
	fi

	enewgroup murmur
	enewuser murmur -1 -1 /var/lib/murmur murmur
}

src_prepare() {
	sed -i \
		-e 's:mumble-server:murmur:g' \
		scripts/murmur.conf \
		scripts/murmur.ini.system \
		|| die "sed failed."
}

src_configure() {
	use debug || conf_add="${conf_add} release"
	use debug && conf_add="${conf_add} symbols debug"
	use pch || echo "CONFIG-=precompile_header" >> src/mumble.pri

	eqmake4 main.pro -recursive \
		CONFIG+="${conf_add} no-client no-bundled-speex" \
		|| die "eqmake4 failed."
}

src_install() {
	dodoc README CHANGES || die "Installing docs failed."
	docinto scripts ; dodoc scripts/*.php scripts/*.pl

	local dir
	if use debug; then
		dir=debug
	else
		dir=release
	fi

	dobin "${dir}"/murmurd || die "Installing murmurd failed."

	insinto /etc/murmur/
	newins scripts/murmur.ini.system murmur.ini

	if use logrotate; then
		insinto /etc/logrotate.d/
		newins "${FILESDIR}"/murmur.logrotate murmur
	fi

	insinto /etc/dbus-1/system.d/
	doins scripts/murmur.conf

	newinitd "${FILESDIR}"/murmur.initd murmur
	newconfd "${FILESDIR}"/murmur.confd murmur

	keepdir /var/lib/murmur /var/run/murmur /var/log/murmur
	fowners -R murmur /var/lib/murmur /var/run/murmur /var/log/murmur
	fperms 750 /var/lib/murmur /var/run/murmur /var/log/murmur

	doman man/murmurd.1
}

pkg_postinst() {
	echo
	elog "Useful scripts are located in /usr/share/doc/murmur-${PV}/scripts."
	elog "Please execute:"
	elog "murmurd -ini /etc/murmur/murmur.ini -supw <pw>"
	elog "chown murmur:murmur /var/lib/murmur/murmur.sqlite"
	elog "to set the inbuild 'SuperUser' password before starting murmur."
	elog "Please restart dbus before starting murmur,"
	elog "or dbus registration will fail."
	echo
}

