# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-shion/canna-shion-20010916.ebuild,v 1.8 2006/10/21 00:10:03 flameeyes Exp $

inherit cannadic

IUSE=""

DESCRIPTION="Canna support dictionary to improve kana-kanji conversion"
HOMEPAGE="http://www.coolbrain.net/shion.html"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"
#SRC_URI="http://www.coolbrain.net/dl/shion/shion.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 alpha ppc ppc64 ~amd64"

DEPEND=">=app-i18n/canna-3.6_p3-r1"

S="${WORKDIR}/${PN/canna-/}"

CANNADICS="pub sup basho scien kaom keisan"
DOCS="README COPYRIGHT"

src_compile() {
	for d in $CANNADICS ; do
		einfo "Compiling $d.ctd..."
		mkbindic $d.ctd || die
	done
}
