# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-0.5.ebuild,v 1.3 2004/03/26 23:10:07 aliz Exp $

IUSE=""
DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist/"
SRC_URI="http://linux.nawebu.cz/wmcliphist/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	emake || die
}

src_install() {
	dobin wmcliphist
	dodoc ChangeLog README
	newdoc .wmcliphistrc wmcliphistrc.sample
}
