# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.7.4.ebuild,v 1.6 2004/03/24 14:32:38 weeve Exp $

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://gdome2.cs.unibo.it/"
SRC_URI="http://gdome2.cs.unibo.it/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ~ppc"

DEPEND=">=dev-libs/libxml2-2.4.21
	=dev-libs/glib-1.2*"

# has the option of using glib-2 by using --enable-glib-2

src_compile() {

	econf \
		--with-html-dir=${D}/usr/share/doc || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dodoc AUTHORS ChangeLog COPYING* INSTALL MAINTAINERS README
}
