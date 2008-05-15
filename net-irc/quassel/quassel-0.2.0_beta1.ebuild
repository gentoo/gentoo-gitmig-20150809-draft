# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.2.0_beta1.ebuild,v 1.1 2008/05/15 15:54:49 flameeyes Exp $

EAPI=1

inherit qt4

if [[ ${PV} == 9999 ]]; then
	inherit subversion
	ESVN_REPO_URI="http://svn.quassel-irc.org/trunk"
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
DEPEND="${RDEPEND}"

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
	local BUILD=""
	use server && BUILD="${BUILD} core"
	use X && BUILD="${BUILD} qtclient"

	eqmake4 ${PN}.pro BUILD="${BUILD}" || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	local targets=""
	use server && targets="${targets} build/targets/quasselcore"
	use X && targets="${targets} build/targets/quasselclient"
	dobin $targets  || die "quasselcore install failed"

	domenu ${PN}.desktop || die "desktop file install failed"

	dodoc ChangeLog README README.Qtopia || "dodoc failed"
}
