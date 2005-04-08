# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnome-alsamixer/gnome-alsamixer-0.9.6.ebuild,v 1.8 2005/04/08 17:31:32 hansmi Exp $

inherit eutils

IUSE=""
DESCRIPTION="Gnome 2 based ALSA Mixer"
HOMEPAGE="http://www.paw.co.za/projects/gnome-alsamixer"
SRC_URI="ftp://ftp.paw.co.za/pub/PAW/sources/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
RDEPEND=">=media-libs/alsa-lib-0.9.0_rc1
	 >=x11-libs/gtk+-2.0.6
	 >=gnome-base/libgnomeui-2.0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/desktop-file-utils"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gtk24.patch
}

src_install() {
	make DESTDIR=${D} install || die

	# manuall install menu entry
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop

	dodoc AUTHORS COPYING ChangeLog INSTALL
}
