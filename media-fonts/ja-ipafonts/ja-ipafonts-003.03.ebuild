# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ja-ipafonts/ja-ipafonts-003.03.ebuild,v 1.1 2011/05/11 22:45:31 matsuu Exp $

inherit font

MY_P="IPAfont${PV/.}"
DESCRIPTION="Japanese TrueType fonts developed by IPA (Information-technology Promotion Agency, Japan)"
HOMEPAGE="http://ossipedia.ipa.go.jp/ipafont/"
SRC_URI="http://info.openlab.ipa.go.jp/ipafont/fontdata/${MY_P}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

S="${WORKDIR}/${MY_P}"
FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )

DOCS="Readme_${MY_P}.txt"

# Only installs fonts
RESTRICT="strip binchecks"
