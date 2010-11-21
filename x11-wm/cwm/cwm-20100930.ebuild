# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-20100930.ebuild,v 1.5 2010/11/21 19:37:03 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${PF}.patch.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ~arm ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	sys-devel/bison"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch linux.patch
}

src_compile() {
	export LDADD="${LDFLAGS}"
	tc-export CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
