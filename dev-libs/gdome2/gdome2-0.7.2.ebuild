# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.7.2.ebuild,v 1.1 2002/07/09 21:33:12 blizzy Exp $

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://phd.cs.unibo.it/gdome2/"
SRC_URI="http://phd.cs.unibo.it/gdome2/tarball/${P}.tar.gz"
LICENSE="LPGL-2.1"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=dev-libs/libxml2-2.4.21
	>=dev-libs/glib-1.2.10"
DEPEND="${RDEPEND}"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--with-html-dir=${D}/usr/doc \
	|| die "configure problem"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"

	dohtml /usr/doc/${P}/*
	dodoc AUTHORS ChangeLog COPYING* INSTALL MAINTAINERS README
}
