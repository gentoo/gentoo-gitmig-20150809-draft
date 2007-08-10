# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.6.3.ebuild,v 1.3 2007/08/10 10:02:19 armin76 Exp $

inherit kde

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://kplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/kplayer/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-video/mplayer-1.0_rc1"

DEPEND="${RDEPEND}"

LANGS="br ca cs cy da de el en_GB es et fi fr ga gl he hu it ja nb nl pa pl
pt_BR pt ru sr@Latn sr sv tr zh_CN"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.1

src_unpack () {
	kde_src_unpack
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done
	rm -f "${S}/configure"
}
