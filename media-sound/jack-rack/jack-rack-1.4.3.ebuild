# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-rack/jack-rack-1.4.3.ebuild,v 1.2 2004/03/14 13:22:42 dholm Exp $

DESCRIPTION="JACK Rack is an effects rack for the JACK low latency audio API."
HOMEPAGE="http://arb.bash.sh/~rah/software/jack-rack/"
SRC_URI="http://arb.bash.sh/~rah/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE="gnome"

DEPEND="media-libs/ladcca \
	media-libs/liblrdf \
	>=gtk+-2.0.6-r2 \
	>=ladspa-sdk-1.12 \
	dev-libs/libxml2 \
	virtual/jack"

S=${WORKDIR}/${P}

src_compile() {
	econf `use_enable gnome`
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
