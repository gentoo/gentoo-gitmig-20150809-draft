# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-9999.ebuild,v 1.8 2008/09/01 18:51:57 jokey Exp $

EAPI=1

inherit cmake-utils eutils

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="git://git.quassel-irc.org/quassel.git"

	case ${PV} in
		0.2.9999) EGIT_BRANCH="0.2" ;;
		*) EGIT_BRANCH="master"
	esac
	inherit git
else
	MY_P="${P/_/-}"
	SRC_URI="http://quassel-irc.org/system/files/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="+dbus debug +server +ssl +X"

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

DOCS="ChangeLog README README.Qtopia"

pkg_setup() {
	if ! use server && ! use X; then
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
	local mycmakeargs="
		$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want X QTCLIENT)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with ssl OPENSSL)
		-DWANT_MONO=OFF"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	# Only install the icons if the X client was installed
	if use X; then
		insinto /usr/share/icons/hicolor
		# avoid the connected/ directory, get only the ${size}x${size}
		doins -r "${S}"/src/icons/quassel/*x* || die "installing icons failed"
	fi

	if use server; then
		newinitd "${FILESDIR}"/quasselcore.init quasselcore || die "newinitd failed"
		newconfd "${FILESDIR}"/quasselcore.conf quasselcore || die "newconfd failed"
	fi
}

pkg_postinst() {
	if use server; then
		ewarn "In order to use the quassel init script you must set the"
		ewarn "QUASSEL_USER variable in /etc/conf.d/quasselcore to your username."
	fi
}
