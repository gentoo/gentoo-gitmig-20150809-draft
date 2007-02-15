# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.7-r1.ebuild,v 1.1 2007/02/15 20:27:41 drac Exp $

inherit eutils

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://huli.org/wavbreaker/"
SRC_URI="http://huli.org/wavbreaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -sparc"
IUSE=""

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CONTRIBUTORS ChangeLog NEWS README TODO
	doicon images/break.png
	make_desktop_entry ${PN} "${PN}" break.png
}
