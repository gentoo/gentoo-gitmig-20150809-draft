# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gtk-recordmydesktop/gtk-recordmydesktop-0.3.5.ebuild,v 1.1 2007/07/26 15:38:10 aballier Exp $

DESCRIPTION="GTK interface for RecordMyDesktop"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10.0
	>=dev-python/pygtk-2
	>=media-video/recordmydesktop-0.3.4"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
