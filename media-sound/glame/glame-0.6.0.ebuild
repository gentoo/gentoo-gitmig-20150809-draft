# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-0.6.0.ebuild,v 1.4 2002/09/21 02:08:09 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Glame is an audio file editing utility."
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"
HOMEPAGE="http://glame.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-util/guile-1.4-r3
	>=dev-util/glade-0.6.2
	>=dev-libs/libxml-1.8.16
	>=media-libs/audiofile-0.2.1"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	einstall || die
	dodoc AUTHORS BUGS COPYING CREDITS Changelog MAINTAINERS NEWS README TODO

}
