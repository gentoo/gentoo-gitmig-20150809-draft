# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fsv/fsv-0.9.ebuild,v 1.11 2006/01/21 19:28:44 nelchael Exp $

IUSE="nls"

DESCRIPTION="3-Dimensional File System Visualizer"
HOMEPAGE="http://fsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~ppc x86"

DEPEND="=x11-libs/gtk+-1.2*
	<x11-libs/gtkglarea-1.99"

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS NOTES TODO
}
