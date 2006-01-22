# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.5.1.ebuild,v 1.15 2006/01/22 14:24:14 plasmaroo Exp $

inherit eutils

DESCRIPTION="A Stroke and Gesture recognition Library"
HOMEPAGE="http://www.etla.net/libstroke/"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1*
	|| ( (	x11-proto/xproto
		x11-libs/libX11
	     )
	     virtual/x11
	)"

RDEPEND="|| ( (	x11-libs/libXi
		x11-libs/libX11
		x11-libs/libXext
	      )
	      virtual/x11
	)"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-m4_syntax.patch
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CREDITS ChangeLog README{,.libgstroke}
}
