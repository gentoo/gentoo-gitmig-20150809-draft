# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-rack/jack-rack-1.4.3.ebuild,v 1.12 2004/11/12 08:47:18 eradicator Exp $

IUSE="gnome ladcca"

inherit eutils

DESCRIPTION="JACK Rack is an effects rack for the JACK low latency audio API."
HOMEPAGE="http://arb.bash.sh/~rah/software/jack-rack/"
SRC_URI="http://arb.bash.sh/~rah/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="ladcca? ( >=media-libs/ladcca-0.4 )
	media-libs/liblrdf
	>=x11-libs/gtk+-2.0.6-r2
	>=media-libs/ladspa-sdk-1.12
	dev-libs/libxml2
	media-sound/jack-audio-connection-kit"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gtkdep.patch
}

src_compile() {
	econf `use_enable gnome` || die "econf failed"
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
}
