# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.99.9.ebuild,v 1.12 2006/08/30 20:25:42 gustavoz Exp $

IUSE="vorbis"

DESCRIPTION="Easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://www.debain.org/?session=&site=project&project=3"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step4/releases/cantus_2/${PN}_2-${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="vorbis? ( media-libs/libvorbis media-libs/libogg )
	>=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2.0.1"

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
