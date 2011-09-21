# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/luakit/luakit-9999.ebuild,v 1.18 2011/09/21 07:47:32 mgorny Exp $

EAPI=3

IUSE="luajit vim-syntax"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/mason-larobina/${PN}.git
		https://github.com/mason-larobina/${PN}.git"
	EGIT_BRANCH="develop"
	KEYWORDS=""
	SRC_URI=""
else
	inherit base
	MY_PV="${PV/_p/-r}"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/mason-larobina/${PN}/tarball/${MY_PV} -> ${P}.tar.gz"
fi

DESCRIPTION="fast, small, webkit-gtk based micro-browser extensible by lua"
HOMEPAGE="http://www.luakit.org"

LICENSE="GPL-3"
SLOT="0"

COMMON_DEPEND="
	luajit? ( dev-lang/luajit:2 )
	!luajit? ( >=dev-lang/lua-5.1 )
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libunique:1
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
"

DEPEND="
	dev-util/pkgconfig
	sys-apps/help2man
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	dev-lua/luafilesystem
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-2_src_unpack
	else
		base_src_unpack
		mv mason-larobina-luakit-* "${S}"
	fi
}

src_compile() {
	myconf="PREFIX=/usr DEVELOPMENT_PATHS=0"
	use luajit && myconf+=" USE_LUAJIT=1"

	if [[ ${PV} != *9999* ]]; then
		myconf+=" VERSION=${PV}"
	fi

	emake ${myconf} || die "emake failed"
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
