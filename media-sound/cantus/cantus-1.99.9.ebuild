# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.99.9.ebuild,v 1.4 2004/03/01 05:37:12 eradicator Exp $

DESCRIPTION="Easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://www.debain.org/?session=&site=project&project=1"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step4/releases/cantus_2/${PN}_2-${PV}-1.tar.gz"
IUSE="gnome"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 amd64"

DEPEND="vorbis? ( media-libs/libvorbis
		media-libs/libogg )
		>=x11-libs/gtk+-2.2
		>=gnome-base/libglade-2.0.1"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-2-${PV}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/doc
	dodoc TODO README NEWS INSTALL ChangeLog COPYING AUTHORS ABOUT-NLS
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/cantus.png
	if [ "`use gnome`" ] ; then
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/cantus2.desktop
	fi
}
