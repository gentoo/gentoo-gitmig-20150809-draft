# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/luakit/luakit-9999.ebuild,v 1.5 2010/08/27 12:00:23 wired Exp $

EAPI=3

IUSE=""

if [[ ${PV} == *9999* ]]; then
	inherit git
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/mason-larobina/luakit.git"}
	[[ ${EGIT_BRANCH} == "master" ]] && EGIT_BRANCH="develop"
	[[ ${EGIT_COMMIT} == "master" ]] && EGIT_COMMIT=${EGIT_BRANCH}
	KEYWORDS=""
	SRC_URI=""
else
	inherit base
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://github.com/mason-larobina/${PN}/tarball/${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="fast, small, webkit-gtk based micro-browser extensible by lua"
HOMEPAGE="http://www.luakit.org"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-lang/lua-5.1
	dev-libs/glib:2
	net-libs/libsoup
	net-libs/webkit-gtk
	x11-libs/gtk+:2
"

DEPEND="
	dev-util/gperf
	sys-apps/help2man
	${RDEPEND}
"

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		git_src_prepare
	else
		cd "${WORKDIR}"/mason-larobina-luakit-*
		S=$(pwd)
	fi
}

src_compile() {
	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" install ||
		die "Installation failed"
}
