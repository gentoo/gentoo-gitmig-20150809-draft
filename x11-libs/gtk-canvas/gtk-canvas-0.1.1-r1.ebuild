# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-canvas/gtk-canvas-0.1.1-r1.ebuild,v 1.3 2008/07/27 11:00:51 markusle Exp $

DESCRIPTION="Backport of the GnomeCanvas widget to GTK+"
HOMEPAGE="http://www.atai.org/gtk-canvas/"
SRC_URI="http://www.atai.org/gtk-canvas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RDEPEND="=x11-libs/gtk+-1.2*
	!gnome-base/gnome-libs
	media-libs/imlib"
DEPEND="${RDEPEND}"

src_compile() {
	# Busted
	unset LDFLAGS
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
