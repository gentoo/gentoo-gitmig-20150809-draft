# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.99.9.ebuild,v 1.14 2007/08/12 10:29:35 drac Exp $

IUSE="vorbis"

DESCRIPTION="Easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://www.debain.org/?session=&site=project&project=3"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step4/releases/cantus_2/${PN}_2-${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="vorbis? ( media-libs/libvorbis media-libs/libogg )
	>=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-2-${PV}"

src_install() {
	einstall || die
	rm -rf ${D}/usr/doc
	dodoc TODO README NEWS ChangeLog AUTHORS
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/cantus.png

	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/cantus2.desktop

	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/cantus2.desktop
}
