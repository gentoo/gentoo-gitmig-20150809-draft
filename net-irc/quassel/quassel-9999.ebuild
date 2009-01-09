# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-9999.ebuild,v 1.14 2009/01/09 17:53:50 patrick Exp $

EAPI="2"

inherit cmake-utils eutils git

EGIT_REPO_URI="git://git.quassel-irc.org/quassel.git"
EGIT_BRANCH="master"

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="dbus debug kde phonon +server +ssl webkit +X"

LANGS="cs da de fr nb_NO ru tr"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

RDEPEND="
	x11-libs/qt-core:4
	dbus? ( x11-libs/qt-dbus:4 )
	server? (
		x11-libs/qt-sql:4[sqlite]
		x11-libs/qt-script:4
	)
	ssl? (
		dev-libs/openssl
		x11-libs/qt-core:4[ssl]
	)
	X? (
		x11-libs/qt-gui:4
		kde? ( >=kde-base/kdelibs-4.1 )
		phonon? ( || ( media-sound/phonon x11-libs/qt-phonon ) )
		webkit? ( x11-libs/qt-webkit:4 )
	)
	"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	if ! use server && ! use X ; then
		eerror "You have to build one or both of quassel client or server."
		die "Both server and X USE flags unset."
	fi
}

src_configure() {
# Invoke _common_configure_code, cmake and cmake-utils_src_make
# manually until cmake-utils.eclass supports space separated strings as arguments for cmake
# options. Until now multiple languages are not passed to -DLINGUAS and only the first
# language is considered.
	local mycmakeargs="$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want X QTCLIENT)
		$(cmake-utils_use_want X MONO)
		$(cmake-utils_use_with webkit WEBKIT)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with kde KDE)
		$(cmake-utils_use_with phonon PHONON)
		$(cmake-utils_use_with ssl OPENSSL)"

	if use kde ; then
		# We don't use our own phonon backend, so don't enable it; also use system icon themes
		mycmakeargs="${mycmakeargs} -DWITH_PHONON=0 -DOXYGEN_ICONS=External -DQUASSEL_ICONS=External"
	else
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with phonon PHONON)
			-DOXYGEN_ICONS=Builtin -DQUASSEL_ICONS=Builtin"
	fi

	_common_configure_code

	mkdir -p "${WORKDIR}"/${PN}_build
	pushd "${WORKDIR}"/${PN}_build > /dev/null

	cmake -C "${TMPDIR}/gentoo_common_config.cmake" \
		${mycmakeargs} \
		-DLINGUAS="${LINGUAS}" \
		-DCMAKE_INSTALL_DO_STRIP=OFF \
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

	if use server && use ssl ; then
		elog
		elog "To enable SSL support for client/core connections the quasselcore needs"
		elog "a PEM certificate which needs to be stored in ~/.quassel/quasselCert.pem."
		elog "To create the certificate use the following command:"
		elog "openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout ~/.quassel/quasselCert.pem -out ~/.quassel/quasselCert.pem"
	fi
}
