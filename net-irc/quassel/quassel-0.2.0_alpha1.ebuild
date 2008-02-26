# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.2.0_alpha1.ebuild,v 1.1 2008/02/26 01:24:16 flameeyes Exp $

EAPI=1

inherit qt4

MY_P="${P/_alpha/-alpha}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Core/client IRC client."
HOMEPAGE="http://quassel-irc.org/"
SRC_URI="http://quassel-irc.org/system/files/${MY_P}.tar.bz2"

LICENSE="GPL-3"

KEYWORDS="~amd64"

SLOT="0"

IUSE="X debug"

RDEPEND="$(qt4_min_version 4.0)"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/qt:4 sqlite3; then
		eerror "Quassel require Qt 4 built with SQLite support"
		eerror "Please rebuild x11-libs/qt:4 with sqlite3 USE flag enabled."
		die "Missing sqlite3 support in x11-libs/qt:4"
	fi
}

src_compile() {
	local BUILD="core"
	use X && BUILD="${BUILD} qtclient"

	eqmake4 ${PN}.pro BUILD="${BUILD}" || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	local targets="build/targets/quasselcore"
	use X && targets="${targets} build/targets/quasselclient"
	dobin $targets  || die "quasselcore install failed"

	dodoc ChangeLog README README.Qtopia dev-notes/paulk-notes.txt \
		dev-notes/ROADMAP
}
