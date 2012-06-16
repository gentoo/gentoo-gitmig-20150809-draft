# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-9999.ebuild,v 1.3 2012/06/16 21:56:26 xmw Exp $

EAPI=4

EGIT_REPO_URI=https://github.com/chneukirchen/cwm.git
EGIT_BRANCH=linux

inherit flag-o-matic toolchain-funcs git-2

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
	virtual/pkgconfig
	sys-devel/bison"

src_compile() {
	#append-cflags -D_GNU_SOURCE #bug 417047
	emake CFLAGS="${CFLAGS} -D_GNU_SOURCE" CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README
	make_session_desktop ${PN} ${PN}
}
