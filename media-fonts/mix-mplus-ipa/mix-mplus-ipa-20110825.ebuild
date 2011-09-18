# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mix-mplus-ipa/mix-mplus-ipa-20110825.ebuild,v 1.1 2011/09/18 00:21:36 matsuu Exp $

EAPI="4"
inherit font

DESCRIPTION="Mixing mplus and IPA fonts"
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/mix-mplus-ipa/53033/MigMix-1M-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53033/MigMix-1P-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53033/MigMix-2M-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53033/MigMix-2P-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53034/Migu-1C-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53034/Migu-1M-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53034/Migu-1VS-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53034/Migu-2DS-${PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/53034/Migu-2M-${PV}.zip"

LICENSE="mplus-fonts IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

src_prepare() {
	mv */*.${FONT_SUFFIX} "${FONT_S}" || die
}
