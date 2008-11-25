# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-9999.ebuild,v 1.11 2008/11/25 00:24:42 darkside Exp $

EAPI=1

inherit cmake-utils eutils git

EGIT_REPO_URI="git://git.quassel-irc.org/quassel.git"
EGIT_BRANCH="master"

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="+dbus debug +server +ssl +X"

LANGS="nb_NO da de fr ru"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

RDEPEND="x11-libs/qt-core:4
		server? (
			x11-libs/qt-sql:4
			x11-libs/qt-script:4
		)
		X? (
			x11-libs/qt-gui:4
			x11-libs/qt-webkit:4
		)
		dbus? ( x11-libs/qt-dbus:4 )
		ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

DOCS="AUTHORS ChangeLog README"

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
#		"$(cmake-utils_use_with X WEBKIT)"
#		"$(cmake-utils_use_with dbus DBUS)"
#		"$(cmake-utils_use_with ssl OPENSSL)"
#		"-DLINGUAS=\"${LINGUAS}\""
#		'-DOXYGEN_ICONS=Builtin'
#		'-DQUASSEL_ICONS=Builtin'
#		'-DWANT_MONO=OFF' )
#
#	cmake-utils_src_compile

	_common_configure_code

	cmake -C "${TMPDIR}/gentoo_common_config.cmake" \
		$(cmake-utils_use_want server CORE) $(cmake-utils_use_want X QTCLIENT) \
		$(cmake-utils_use_with X WEBKIT) $(cmake-utils_use_with dbus DBUS) \
		$(cmake-utils_use_with ssl OPENSSL) -DLINGUAS="${LINGUAS}" \
		-DOXYGEN_ICONS=Builtin -DQUASSEL_ICONS=Builtin -DWANT_MONO=OFF \
		"${S}" || die "Cmake failed"

	cmake-utils_src_make
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
