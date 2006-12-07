# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-0.95.1.ebuild,v 1.2 2006/12/07 21:05:51 swegener Exp $

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.23"

src_install() {
	emake -j1 install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
