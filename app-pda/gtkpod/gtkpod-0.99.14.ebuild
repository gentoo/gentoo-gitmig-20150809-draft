# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.99.14.ebuild,v 1.2 2009/01/31 06:43:37 tester Exp $

inherit eutils

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac gnome hal ogg"

DEPEND=">=x11-libs/gtk+-2.6.0
	>=media-libs/libid3tag-0.15
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomecanvas-2.14
	>=media-libs/libgpod-0.7.0
	>=net-misc/curl-7.10
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	hal? ( =sys-apps/hal-0.5* )
	aac? ( media-libs/libmp4v2 )
	ogg? ( media-libs/libvorbis )
	flac? ( media-libs/flac )"

src_unpack() {
	unpack ${A}

	# Disable aac forcefully if not enabled
	use aac || sed -i -e s/MP4FileInfo/MP4FileInfoDisabled/g "${S}"/configure
}

src_compile() {
	econf \
		$(use_with hal) \
		$(use_with aac mp4v2) \
		$(use_with ogg) \
		$(use_with flac) \
		$(use_with gnome gnome-vfs ) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README TROUBLESHOOTING
}
