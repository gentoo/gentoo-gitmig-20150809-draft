# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.7.2.ebuild,v 1.12 2004/07/14 14:23:59 agriffis Exp $

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://phd.cs.unibo.it/gdome2/"
SRC_URI="http://phd.cs.unibo.it/gdome2/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.4.21
	>=dev-libs/glib-1.2.10"

src_compile() {
	econf \
		--with-html-dir=${D}/usr/share/doc || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"

	dohtml /usr/doc/${P}/*
	dodoc AUTHORS ChangeLog COPYING* INSTALL MAINTAINERS README
}
