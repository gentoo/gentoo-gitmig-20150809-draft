# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-99999999.ebuild,v 1.4 2011/09/11 22:06:30 xmw Exp $

EAPI=2

EGIT_REPO_URI=https://github.com/chneukirchen/cwm.git
EGIT_BRANCH=linux

inherit eutils toolchain-funcs git-2

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/
	http://github.com/chneukirchen/cwm"
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
	epatch "${FILESDIR}"/${PN}-20110726-Makefile.patch
	export LDADD="${LDFLAGS}"
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop || die
}
