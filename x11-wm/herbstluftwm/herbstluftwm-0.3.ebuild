# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/herbstluftwm/herbstluftwm-0.3.ebuild,v 1.2 2012/06/09 23:55:20 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs bash-completion-r1

DESCRIPTION="A manual tiling window manager for X"
HOMEPAGE="http://wwwcip.cs.fau.de/~re06huxa/herbstluftwm/"
SRC_URI="http://wwwcip.cs.fau.de/~re06huxa/${PN}/tarballs/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples zsh-completion"

CDEPEND=">=dev-libs/glib-2.24:2
	x11-libs/libX11"
RDEPEND="${CDEPEND}
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	epatch "${FILESDIR}"/${P}-install.patch
	epatch "${FILESDIR}"/${P}-verbose-build.patch
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" LD="$(tc-getCC)"
}

src_install() {
	emake INSTALLDIR="${D}" install
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
