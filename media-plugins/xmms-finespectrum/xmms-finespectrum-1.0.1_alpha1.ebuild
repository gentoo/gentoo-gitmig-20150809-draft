# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-finespectrum/xmms-finespectrum-1.0.1_alpha1.ebuild,v 1.9 2004/11/27 20:22:11 corsair Exp $

IUSE=""

inherit gnuconfig

MY_P="${PN/xmms-/}-${PV/_alpha1/alpha}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Fine Spectrum Analyzer visualization plugin for xmms (Like simple spectrum, but with fine lines instead of bars)"
HOMEPAGE="http://www.sourceforge.net/projects/finespectrum/"
SRC_URI="mirror://sourceforge/finespectrum/${MY_P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ia64 ~ppc sparc ~ppc64"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
	dohtml README.html
}
