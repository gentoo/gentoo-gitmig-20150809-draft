# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/herbstluftwm/herbstluftwm-9999.ebuild,v 1.1 2012/06/09 21:50:16 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs bash-completion-r1 git-2

EGIT_REPO_URI="git://git.informatik.uni-erlangen.de/re06huxa/herbstluftwm"

DESCRIPTION="A manual tiling window manager for X"
HOMEPAGE="http://wwwcip.cs.fau.de/~re06huxa/herbstluftwm/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="examples zsh-completion"

CDEPEND=">=dev-libs/glib-2.24:2
	x11-libs/libX11"
RDEPEND="${CDEPEND}
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND="${CDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" COLOR=0 VERBOSE=""
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc BUGS NEWS README

	newbashcomp share/herbstclient-completion herbstclient

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins share/_herbstclient
	fi

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe scripts/*.sh
		docinto examples
		dodoc scripts/README
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
