# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jmax/jmax-4.0.2.ebuild,v 1.2 2004/03/31 18:21:27 eradicator Exp $

inherit eutils

DESCRIPTION="jMax is a visual programming environment for building interactive real-time music and multimedia applications."
HOMEPAGE="http://freesoftware.ircam.fr/rubrique.php3?id_rubrique=2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=virtual/jre-1.4
	media-libs/alsa-lib"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}-work_with_recent_alsa-lib.patch
}

src_install () {
	einstall || die "install failed"

	dodoc AUTHORS ChangeLog JMAX-VERSION LICENCE.fr LICENSE LISEZMOI README
}



pkg_postinst() {
	echo
	einfo "To get started, have a look at the tutorials"
	einfo "in /usr/share/jmax/tutorials/basics"
	echo
}
