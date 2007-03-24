# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnome-alsamixer/gnome-alsamixer-0.9.6.ebuild,v 1.15 2007/03/24 16:29:57 drac Exp $

inherit eutils fdo-mime

DESCRIPTION="Gnome based ALSA Mixer"
HOMEPAGE="http://www.paw.za.org/projects/gnome-alsamixer"
SRC_URI="ftp://ftp.paw.za.org/pub/PAW/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9.0_rc1
	 >=x11-libs/gtk+-2
	 >=gnome-base/libgnomeui-2.0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/desktop-file-utils"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gtk24.patch
	epatch ${FILESDIR}/${P}-fixpath.patch
}

src_install() {
	emake DESTDIR=${D} install || die

	make_desktop_entry gnome-alsamixer "Gnome Alsa Mixer"\
		/usr/share/pixmaps/${PN}/${PN}-icon.png

	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
