# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-20110908-r1.ebuild,v 1.1 2011/10/06 00:00:59 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/
	http://github.com/chneukirchen/cwm"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~sparc ~x86"
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
	make_session_desktop ${PN} ${PN}
}
