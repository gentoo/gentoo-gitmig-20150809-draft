# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.5.1.ebuild,v 1.13 2004/11/04 05:17:22 vapier Exp $

inherit gnuconfig

DESCRIPTION="A Stroke and Gesture recognition Library"
HOMEPAGE="http://www.etla.net/libstroke/"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1*
	virtual/x11"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CREDITS ChangeLog README
}
