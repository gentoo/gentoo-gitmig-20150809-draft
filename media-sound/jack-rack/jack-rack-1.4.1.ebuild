# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-rack/jack-rack-1.4.1.ebuild,v 1.6 2004/03/01 05:37:14 eradicator Exp $

DESCRIPTION="JACK Rack is an effects rack for the JACK low latency audio API."
HOMEPAGE="http://pkl.net/~node/jack-rack.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"

IUSE="gnome"

DEPEND="media-libs/ladcca \
	media-libs/liblrdf \
	>=gtk+-2.0.6-r2 \
	>=ladspa-sdk-1.12 \
	dev-libs/libxml2 \
	virtual/jack"

S=${WORKDIR}/${P}

src_compile() {
	local myconf

	use gnome || myconf="${myconf} --disable-gnome"

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
