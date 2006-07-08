# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.02.ebuild,v 1.7 2006/07/08 03:03:21 squinky86 Exp $

inherit eutils

IUSE=""
S=${WORKDIR}/${P}/src
DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="http://wmbio.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://wmbio.sourceforge.net/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

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
