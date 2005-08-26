# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gaim-smileys/gaim-smileys-20031002.ebuild,v 1.5 2005/08/26 13:45:06 agriffis Exp $

IUSE=""
DESCRIPTION="Snapshot of Available Gaim Smiley Themes"
HOMEPAGE="http://gaim.sourceforge.net/themes.php"
# use absolute links rather than php-redirects from gaim.sf.net
SRC_URI="http://www.kingant.net/oscar/gaim/icq.tar.gz
	http://gaim.sourceforge.net/exhaustive.tar.gz
	http://www.blueridge.net/~rflynn/alien_theme.tar.gz
	http://sascha.darktech.org/trent/small-green-men.tar.gz
	http://www.freestructure.net/~reivec/Bugeyes.tar.gz
	http://www.freestructure.net/~reivec/Kids.tar.gz
	http://www.freestructure.net/~reivec/CrystalAIM.tar.gz
	http://www.geocities.com/pudicio/pengu.tar.gz
	http://www.creamybitches.com/~cheeto/sars/sars.tar.gz
	http://fraggle.alkali.org/downloads/gnu-smileys-1.0.tar.gz
	http://www.freestructure.net/~reivec/EasterAIM.tar.gz
	http://www.ics.uci.edu/~swrobel/Jimmac.tar.gz
	http://www.xeron.cc/main/files/burger.tar.gz
	http://www.xeron.cc/main/files/kitties.tar.gz
	http://www.gnomepro.com/smallsmiles/SmallSmiles.tar.gz
	http://users.skynet.be/xterm/tweak-0.1.2.tar.gz
	http://www.bhtp.com/filthysmilies.tar
	http://www.fr3nd.net/nis/nis.tar.gz
	http://www.skobel.com/mirrors/iboard.tar.gz
	http://www.madcowworld.com/gaim/mwes-1.0.17.tar.gz
	http://www.kde-look.org/content/files/6704-gaimcrystal.tar.gz
	http://perso.wanadoo.fr/mamard55/misc/msn6.0.2.tar.gz
	http://www.macarbens.com/contrib/gaim/smileys/sars-yahoo-1.0.tar.gz
	http://pollux.dhcp.uia.mx/damog/files/DamogDotOrg-0.2.tar.gz
	http://hejieshijie.net/files/Maya.tar.gz
	http://cbl.sytes.net/~aquacable/gs.tar.gz
	http://thebonfire.org/filespace/sftd-1.0.tar.gz
	http://stephane.pontier.free.fr/projects/TrillyPro.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND=">=net-im/gaim-0.59"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	# remove general cruft
	find ${S} -type d -name .xvpics -exec rm -rf '{}' \; 2>/dev/null
	find ${S} -type f -name 'Makefile*' -exec rm -f '{}' \;
	find ${S} -type f -name '*theme*' -a ! -name theme -a ! -name '*.png' -exec rm -f '{}' \;
	find ${S} -type f -name .cvsignore -exec rm -rf '{}' \;
	# remove specific cruft
	rm -rf ${S}/DamogDotOrg/messenger.msn.com
	rm -f ${S}/Jimmac/.theme.swp
	rm -f ${S}/exhaustive/lt_purple.tar
	rm -f ${S}/gnu-smileys-1.0/{COPYING,README}
	rm -f ${S}/nis/LICENSE
	rm -f ${S}/sftd/Thumbs.db
	rm -f ${S}/tweak/README
}

src_install() {
	dodir /usr/share/pixmaps/gaim/smileys
	cp -r ${S}/* ${D}/usr/share/pixmaps/gaim/smileys
}
