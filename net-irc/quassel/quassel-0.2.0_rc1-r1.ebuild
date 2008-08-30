# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.2.0_rc1-r1.ebuild,v 1.1 2008/08/30 19:02:53 jokey Exp $

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

KEYWORDS="~amd64 ~x86"

SLOT="0"

IUSE="+X +server debug"

RDEPEND="|| (
		(
			x11-libs/qt-core:4
			server? (
				x11-libs/qt-sql:4
				x11-libs/qt-script:4
			)
			X? ( x11-libs/qt-gui:4 )
		)
		=x11-libs/qt-4.3*:4
	)"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7"

DOCS="ChangeLog README README.Qtopia"

pkg_setup() {
	if ! use server && ! use X; then
		eerror "You have to build one or both of quassel client or server."
		die "Both server and X USE flags unset."
	fi

	qt44=$(has_version x11-libs/qt-sql && echo yes || echo no)
	if use server && ! built_with_use $([[ ${qt44} == "yes" ]] && echo "x11-libs/qt-sql sqlite" || echo "x11-libs/qt:4 sqlite3"); then
		eerror "Quassel require Qt 4 built with SQLite support"
		if [[ ${qt44} == "yes" ]]; then
			eerror "Please rebuild x11-libs/qt-sql:4 with sqlite USE flag enabled."
			die "Missing sqlite support in x11-libs/qt-sql:4"
		else
			eerror "Please rebuild x11-libs/qt:4 with sqlite3 USE flag enabled."
			die "Missing sqlite3 support in x11-libs/qt:4"
		fi
	fi
}

src_compile() {
	local mycmakeargs="
		$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want X QTCLIENT)
		-DWANT_MONO=OFF
		"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	# Only install the icons if the X client was installed
	if use X; then
		local size
		for size in 16 24 32 48 64 96 128 256 512; do
			insinto /usr/share/icons/hicolor/${size}x${size}
			newins "${S}"/src/icons/quassel/connected/${size}.png quassel.png
		done
	fi

	if use server; then
		newinitd "${FILESDIR}"/quasselcore.init quasselcore
		newconfd "${FILESDIR}"/quasselcore.conf quasselcore
	fi
}

pkg_postinst() {
	if use server; then
		ewarn "In order to use the quassel init script you must set the"
		ewarn "QUASSEL_USER variable in /etc/conf.d/quasselcore to your username."
	fi
}
