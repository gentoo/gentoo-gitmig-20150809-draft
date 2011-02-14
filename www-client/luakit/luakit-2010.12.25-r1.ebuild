# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/luakit/luakit-2010.12.25-r1.ebuild,v 1.1 2011/02/14 07:49:34 wired Exp $

EAPI=3

IUSE="helpers vim-syntax"

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

COMMON_DEPEND="
	>=dev-lang/lua-5.1
	dev-libs/glib:2
	net-libs/libsoup
	net-libs/webkit-gtk
	x11-libs/gtk+:2
"

DEPEND="
	sys-apps/help2man
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	dev-lua/luafilesystem
	helpers? (
		x11-misc/dmenu
	)
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"

PATCHES=(
	# bug 354355
	"${FILESDIR}/${P}-fix-deprecated.patch"
)

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		git_src_prepare
	else
		cd "${WORKDIR}"/mason-larobina-luakit-*
		S=$(pwd)
		base_src_prepare
	fi
}

src_compile() {
	if [[ ${PV} == *9999* ]]; then
		emake PREFIX="/usr"
	else
		emake PREFIX="/usr" VERSION="${PV}"
	fi
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" install ||
		die "Installation failed"

	if use vim-syntax; then
		local t
		for t in $(ls "${S}"/extras/vim/); do
			insinto /usr/share/vim/vimfiles/"${t}"
			doins "${S}"/extras/vim/"${t}"/luakit.vim ||
				die "vim-${t} doins failed"
		done
	fi
}
