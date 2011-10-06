# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-99999999.ebuild,v 1.5 2011/10/06 00:20:06 xmw Exp $

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

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	dodoc README || die
	make_session_desktop ${PN} ${PN}
}
