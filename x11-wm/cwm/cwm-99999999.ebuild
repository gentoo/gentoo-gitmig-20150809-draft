# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-99999999.ebuild,v 1.1 2011/02/18 15:37:05 xmw Exp $

EAPI=2

EGIT_REPO_URI=https://github.com/chneukirchen/cwm.git
EGIT_BRANCH=linux

inherit eutils toolchain-funcs git

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/
	https://github.com/chneukirchen/cwm.git"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/bison"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20110213-Makefile.patch
}

src_compile() {
	export LDADD="${LDFLAGS}"
	#export YACC=""
	tc-export CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
