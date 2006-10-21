# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-zipcode/canna-zipcode-20021021-r2.ebuild,v 1.6 2006/10/21 00:12:53 flameeyes Exp $

inherit cannadic

MY_P="${P/canna-/}"
MY_DATE="030726"

DESCRIPTION="Japanese Zipcode dictionary for Canna"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/canna/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/canna/${MY_P}.tar.bz2
	http://gentoojp.sourceforge.jp/distfiles/ken_all_${MY_DATE}.lzh
	http://gentoojp.sourceforge.jp/distfiles/jigyosyo_${MY_DATE}.lzh"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=app-i18n/canna-3.6_p3-r1
	dev-lang/perl
	app-i18n/nkf
	app-arch/lha"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
CANNADICS="zipcode jigyousyo"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	lha e ${DISTDIR}/ken_all_${MY_DATE}.lzh
	lha e ${DISTDIR}/jigyosyo_${MY_DATE}.lzh
	touch *.csv
}

src_compile() {
	make all || die
	mkbindic zipcode.t || die
	mkbindic jigyosyo.t || die
}
