# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-0.5.ebuild,v 1.4 2004/04/12 03:34:15 weeve Exp $

IUSE=""
DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist/"
SRC_URI="http://linux.nawebu.cz/wmcliphist/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc"
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
