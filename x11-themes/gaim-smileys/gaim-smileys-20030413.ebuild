# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gaim-smileys/gaim-smileys-20030413.ebuild,v 1.1 2003/04/13 19:15:18 liquidx Exp $

RESTRICT="${RESTRICT} nostrip"

DESCRIPTION="Snapshot of Available Gaim Smiley Themes"
HOMEPAGE="http://gaim.sourceforge.net/themes.php"
SRC_URI="http://www.ics.uci.edu/~swrobel/Jimmac.tar.gz
	http://www.kingant.net/oscar/gaim/icq.tar.gz
	http://gaim.sourceforge.net/exhaustive.tar.gz
	http://www.blueridge.net/~rflynn/alien_theme.tar.gz
	http://sascha.darktech.org/trent/small-green-men.tar.gz
	http://www.freestructure.net/~reivec/Bugeyes.tar.gz
	http://www.freestructure.net/~reivec/Kids.tar.gz
	http://www.freestructure.net/~reivec/CrystalAIM.tar.gz
	http://www.politicalunrest.net/dl/iboard.tar.gz
	http://www.freestructure.net/~reivec/EasterAIM.tar.gz
	http://www.xeron.cc/smileys/burger.tar.gz
	http://www.xeron.cc/smileys/kitties.tar.gz
	http://www.gnomepro.com/smallsmiles/SmallSmiles.tar.gz
	http://users.skynet.be/xterm/tweak-0.1.2.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=net-im/gaim-0.59"
S=${WORKDIR}

src_compile() {
	einfo "No compilation required"
}

src_install() {
	cd ${WORKDIR}
	dodir /usr/share/pixmaps/gaim/smileys
	for x in *; do
		if [ -d ${x} ]; then
			einfo "Installing ${x} Smileys"
			cp -ar ${x} ${D}/usr/share/pixmaps/gaim/smileys
		fi
	done
}
