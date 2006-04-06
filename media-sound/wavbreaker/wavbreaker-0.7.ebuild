# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.7.ebuild,v 1.1 2006/04/06 00:33:54 tcort Exp $

inherit eutils

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://huli.org/wavbreaker/"
SRC_URI="http://huli.org/wavbreaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -sparc"
IUSE=""

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.0"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog README NEWS
}
