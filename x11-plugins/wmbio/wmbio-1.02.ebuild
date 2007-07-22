# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.02.ebuild,v 1.8 2007/07/22 05:21:53 dberkholz Exp $

inherit eutils

IUSE=""
S=${WORKDIR}/${P}/src
DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="http://wmbio.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://wmbio.sourceforge.net/"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ppc64 ~sparc x86"

src_unpack()
{
	unpack ${A}
	cd ${S}
	# Honour Gentoo CFLAGS
	epatch ${FILESDIR}/${PN}-Makefile.patch
}

src_compile()
{
	emake || die "Compilation failed"
}

src_install ()
{
	dobin wmbio
	cd ..
	dodoc AUTHORS README NEWS Changelog
}
