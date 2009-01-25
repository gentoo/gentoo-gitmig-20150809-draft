# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.3.0.3.ebuild,v 1.3 2009/01/25 14:02:30 armin76 Exp $

EAPI=1

inherit cmake-utils eutils

MY_P="${P/_/-}"

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"
SRC_URI="http://quassel-irc.org/pub/${MY_P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+dbus debug +server +ssl +X"

LANGS="nb_NO da de fr"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

RDEPEND="x11-libs/qt-core:4
		server? (
			x11-libs/qt-sql:4
			x11-libs/qt-script:4
		)
		X? ( x11-libs/qt-gui:4 )
		dbus? ( x11-libs/qt-dbus )
		ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7"

DOCS="AUTHORS ChangeLog README README.Qtopia"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use server && ! use X ; then
		eerror "You have to build one or both of quassel client or server."
		die "Both server and X USE flags unset."
	fi

	if use server && ! built_with_use x11-libs/qt-sql sqlite ; then
		eerror "Please rebuild x11-libs/qt-sql:4 with sqlite USE flag enabled."
		die "Missing sqlite support in x11-libs/qt-sql:4"
	fi

	if use ssl && ! built_with_use x11-libs/qt-core ssl ; then
		eerror "Please rebuild x11-libs/qt-core:4 with ssl USE flag enabled."
		die "Missing ssl support in x11-libs/qt-core:4"
	fi
}

src_compile() {
# Comment this out and invoke _common_configure_code, cmake and cmake-utils_src_make
# manually until cmake-utils.eclass supports space separated strings as arguments for cmake
# options. Until now multiple languages are not passed to -DLINGUAS and only the first
# language is considered.
#
#	local mycmakeargs=(
#		"$(cmake-utils_use_want server CORE)"
#		"$(cmake-utils_use_want X QTCLIENT)"
#		"$(cmake-utils_use_with dbus DBUS)"
#		"$(cmake-utils_use_with ssl OPENSSL)"
#		"-DLINGUAS=\"${LINGUAS}\""
#		'-DWANT_MONO=OFF' )
#
#	cmake-utils_src_compile

	_common_configure_code

	cmake -C "${TMPDIR}/gentoo_common_config.cmake" \
		$(cmake-utils_use_want server CORE) $(cmake-utils_use_want X QTCLIENT) \
		$(cmake-utils_use_with dbus DBUS) $(cmake-utils_use_with ssl OPENSSL) \
		-DLINGUAS="${LINGUAS}" -DWANT_MONO=OFF \
		"${S}" || die "Cmake failed"

	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install

	# Only install the icons if the X client was installed
	if use X ; then
		insinto /usr/share/icons/hicolor
		# avoid the connected/ directory, get only the ${size}x${size}
		doins -r "${S}"/src/icons/quassel/*x* || die "installing quassel icons failed"
	fi

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
