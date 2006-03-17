# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/gfsview/gfsview-0.4.ebuild,v 1.2 2006/03/17 05:10:00 deltacow Exp $

inherit eutils

DESCRIPTION="GfsView is a graphical viewer for Gerris simulation files."
HOMEPAGE="http://gfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=">=x11-libs/gtkglext-1.0.6
	>=x11-libs/gtk+-2.4.0
	>=sci-libs/gerris-0.8.0"

src_unpack() {
	unpack "${A}" || die "Unpacking the source failed"
	cd "${S}" || die "Failed to change directory"

	# apply upstream patch to fix crashes when
	# clicking on menu items
	epatch "${FILESDIR}"/gtk-client-events-handling.patch
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}


