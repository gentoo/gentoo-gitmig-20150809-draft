# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.99.10.ebuild,v 1.1 2007/06/28 04:33:05 tester Exp $

inherit eutils

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aac"

DEPEND=">=x11-libs/gtk+-2.4.0
	>=media-libs/libid3tag-0.15
	>=gnome-base/libglade-2
	>=media-libs/libgpod-0.4.2
	aac? ( media-libs/libmp4v2 )"

src_unpack() {
	unpack ${A}

	# Disable aac forcefully if not enabled
	use aac || sed -i -e s/MP4FileInfo/MP4FileInfoDisabled/g configure
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README TROUBLESHOOTING
}
