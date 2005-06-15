# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/potamus/potamus-20040414.ebuild,v 1.2 2005/06/15 19:36:57 sekretarz Exp $

inherit eutils

DESCRIPTION="Potamus, the GTK+ 2 sucessor to gnu xhippo"
HOMEPAGE="http://offog.org/code/potamus.html"
SRC_URI="http://offog.org/files/snapshots/potamus/${PN}-CVS-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND=">=x11-libs/gtk+-2.0.0
		>=gnome-base/libglade-2.0.0"
RDEPEND="${DEPEND}
		>=media-video/mplayer-0.92"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-Makefile.patch
}

src_compile() {

	# We need to remove the azz specific bits from the makefile, so the
	# resiyrces can be found OK

	mv Makefile Makefile.old
	sed -e 's/DESTDIR =//' -e 's/prefix = \/home\/azz\/src\/potamus/prefix = \/usr/' < Makefile.old > Makefile

	emake DESTDIR=${D} || die "emake failed"

}

src_install() {
	make DESTDIR=${D} install || die
}
