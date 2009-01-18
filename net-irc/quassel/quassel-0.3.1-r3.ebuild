# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.3.1-r3.ebuild,v 1.1 2009/01/18 19:44:40 jokey Exp $

EAPI=2

inherit cmake-utils eutils

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"
SRC_URI="http://quassel-irc.org/pub/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+dbus debug monolithic +server +ssl +X"

LANGS="nb_NO da de fr ru"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

RDEPEND="
	x11-libs/qt-core:4
	dbus? ( x11-libs/qt-dbus:4 )
	monolithic? (
		x11-libs/qt-sql:4[sqlite]
		x11-libs/qt-script:4
		x11-libs/qt-gui:4
		x11-libs/qt-webkit:4
	)
	!monolithic? (
		server? (
			x11-libs/qt-sql:4[sqlite]
			x11-libs/qt-script:4
		)
		X? (
			x11-libs/qt-gui:4
			x11-libs/qt-webkit:4
		)
	)
	ssl? (
		dev-libs/openssl
		x11-libs/qt-core:4[ssl]
	)
	"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	if ! use monolithic && ! use server && ! use X ; then
		eerror "You have to build at least one of the monolithic client (USE=monolithic),"
		eerror "the quasselclient (USE=X) or the quasselcore (USE=server)."
		die "monolithic, server and X flag unset."
	fi
}

src_compile() {
# Comment this out and invoke _common_configure_code and cmake manually until cmake-utils.eclass
# supports space separated strings as arguments for cmake options or quassel changes the
# separator. Until now multiple languages are not passed to -DLINGUAS and only the first
# language is considered.

	local mycmakeargs="$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want X QTCLIENT)
		$(cmake-utils_use_want X MONO)
		$(cmake-utils_use_with X WEBKIT)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with ssl OPENSSL)
		-DOXYGEN_ICONS=Builtin
		-DQUASSEL_ICONS=Builtin"

	_common_configure_code

	mkdir -p "${WORKDIR}"/${PN}_build
	pushd "${WORKDIR}"/${PN}_build > /dev/null

	cmake -C "${TMPDIR}/gentoo_common_config.cmake" \
		${mycmakeargs} \
		-DLINGUAS="${LINGUAS}" \
		"${S}" || die "Cmake failed"
}

src_install() {
	cmake-utils_src_install
	if use server ; then
		newinitd "${FILESDIR}"/quasselcore.init quasselcore || die "newinitd failed"
		newconfd "${FILESDIR}"/quasselcore.conf quasselcore || die "newconfd failed"

		insinto /usr/share/doc/${PF}
		doins "${S}"/scripts/manageusers.py || die "installing manageusers.py failed"
	fi
}

pkg_postinst() {
	if use server ; then
		ewarn
		ewarn "In order to use the quassel init script you must set the"
		ewarn "QUASSEL_USER variable in /etc/conf.d/quasselcore to your username."
		ewarn "Note: This is the user who runs the quasselcore and is independent"
		ewarn "from the users you set up in the quasselclient."
		elog
		elog "Adding more than one user or changing username/password is not"
		elog "possible via the quasselclient yet. If you need to do these things"
		elog "you have to use the manageusers.py script, which has been installed in"
		elog "/usr/share/doc/${PF}".
		elog "Please make sure that the quasselcore is stopped before adding more users."
	fi

	if ( use server || use monolithic ) && use ssl ; then
		elog
		elog "To enable SSL support for client/core connections the quasselcore needs"
		elog "a PEM certificate which needs to be stored in ~/.quassel/quasselCert.pem."
		elog "To create the certificate use the following command:"
		elog "openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout ~/.quassel/quasselCert.pem -out ~/.quassel/quasselCert.pem"
	fi
}
