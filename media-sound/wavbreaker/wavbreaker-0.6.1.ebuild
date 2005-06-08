# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.6.1.ebuild,v 1.2 2005/06/08 15:22:10 luckyduck Exp $

inherit eutils

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://huli.org/wavbreaker/"
SRC_URI="http://huli.org/wavbreaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -sparc"
IUSE=""

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.0
	virtual/libc"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog INSTALL README NEWS
}
