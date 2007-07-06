# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/tap-plugins/tap-plugins-0.7.0.ebuild,v 1.5 2007/07/06 22:23:05 aballier Exp $
#

IUSE=""

DESCRIPTION="TAP LADSPA plugins package. Contains DeEsser, Dynamics, Equalizer, Reverb, Stereo Echo, Tremolo"
HOMEPAGE="http://tap-plugins.sourceforge.net"
SRC_URI="mirror://sourceforge/tap-plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="media-libs/ladspa-sdk"

src_compile() {
	emake || die
}

src_install() {
	dodoc README CREDITS
	dohtml ${S}/doc/*
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
	insinto /usr/share/ladspa/rdf
	insopts -m0644
	doins *.rdf
}
