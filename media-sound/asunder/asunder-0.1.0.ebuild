# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/asunder/asunder-0.1.0.ebuild,v 1.1 2005/03/29 13:02:22 luckyduck Exp $

MY_P=Asunder-${PV}
S=${WORKDIR}/${MY_P}

IUSE="doc mp3 ogg flac"

DESCRIPTION="Asunder is a graphical CD ripper and encoder"
SRC_URI="http://ericlathrop.com/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://ericlathrop.com/asunder/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.4
	>=media-libs/libcddb-0.9.5
	media-sound/cdparanoia
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR=${D} install
	dodir /usr/share/applications
	cp ${FILESDIR}/asunder.desktop ${D}/usr/share/applications
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
