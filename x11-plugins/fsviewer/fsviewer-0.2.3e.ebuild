# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.3e.ebuild,v 1.3 2003/02/13 17:22:20 vapier Exp $

DESCRIPTION="file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/fsviewer/${PN}.app-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="x11-wm/WindowMaker"

S="${WORKDIR}/${PN}.app-${PV}"

src_compile() {

	econf --with-appspath=/usr/share/GNUstep \
		|| die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

}
