# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-1.0.12.ebuild,v 1.13 2004/02/17 22:56:47 agriffis Exp $

DESCRIPTION="preprocessor for making GTK+ objects with inline C code"
SRC_URI="http://ftp.5z.com/pub/gob/${P}.tar.gz"
HOMEPAGE="http://www.5z.com/jirka/gob.html"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

RDEPEND="=dev-libs/glib-1.2*"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
