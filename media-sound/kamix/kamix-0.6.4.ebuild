# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kamix/kamix-0.6.4.ebuild,v 1.1 2005/10/30 22:02:01 flameeyes Exp $

inherit kde

MY_P="${P}-2"

DESCRIPTION="A mixer for KDE and ALSA."
HOMEPAGE="http://kamix.sourceforge.net/"
SRC_URI="mirror://sourceforge/kamix/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0.9"

need-kde 3

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${P}-misc.patch"
}

src_compile() {
	myconf="$(use_enable arts vumeter)"

	kde_src_compile
}
