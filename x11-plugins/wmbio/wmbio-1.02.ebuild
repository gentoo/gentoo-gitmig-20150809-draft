# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.02.ebuild,v 1.3 2004/09/03 02:38:28 tgall Exp $

inherit eutils

IUSE=""
S=${WORKDIR}/${P}/src
DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="http://wmbio.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://wmbio.sourceforge.net/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ppc64"

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
