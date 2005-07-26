# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fsv/fsv-0.9.ebuild,v 1.9 2005/07/26 14:06:34 dholm Exp $

IUSE="nls"

DESCRIPTION="3-Dimensional File System Visualizer"
HOMEPAGE="http://fsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~ppc x86"

DEPEND="virtual/opengl
	virtual/x11
	<x11-libs/gtkglarea-1.99"


src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING NOTES TODO
}
