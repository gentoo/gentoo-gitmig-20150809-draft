# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fsv/fsv-0.9.ebuild,v 1.3 2003/09/05 23:18:18 msterret Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="3-Dimensional File System Visualizer"
HOMEPAGE="http://fsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND="virtual/opengl
	virtual/x11
	<x11-libs/gtkglarea-1.99"


src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING NOTES TODO
}
