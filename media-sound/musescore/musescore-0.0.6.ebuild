# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.0.6.ebuild,v 1.9 2004/11/23 09:55:23 eradicator Exp $

IUSE=""

inherit kde eutils

MY_P=mscore-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Music Score Typesetter"
HOMEPAGE="http://muse.seh.de/mscore/index.php"
SRC_URI="http://muse.seh.de/mscore/bin//${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc x86"

DEPEND=">=x11-libs/qt-3.1.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-assert.patch
}

src_compile() {
	addwrite "${QTDIR}/etc/settings"
	econf --disable-qttest || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README.translate TODO
}
