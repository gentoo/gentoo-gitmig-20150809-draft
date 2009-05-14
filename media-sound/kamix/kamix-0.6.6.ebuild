# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kamix/kamix-0.6.6.ebuild,v 1.7 2009/05/14 05:06:09 ssuominen Exp $

inherit kde

DESCRIPTION="A mixer for KDE and ALSA."
HOMEPAGE="http://kamix.sourceforge.net/"
SRC_URI="mirror://sourceforge/kamix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

need-kde 3.5

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="$(use_enable arts vumeter)"
	kde_src_compile
}
