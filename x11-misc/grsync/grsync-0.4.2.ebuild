# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grsync/grsync-0.4.2.ebuild,v 1.2 2006/07/15 07:25:21 dertobi123 Exp $

inherit eutils gnome2

DESCRIPTION="A gtk frontend to rsync"
HOMEPAGE="http://www.opbyte.it/grsync/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""
SRC_URI="http://www.opbyte.it/release/${P}.tar.gz"

RDEPEND=">=x11-libs/gtk+-2.6
	net-misc/rsync"

DEPEND="${RDEPEND}"

DOCS="AUTHORS NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '189s/$(DESTDIR)//' Makefile.in || die "sed failed"
}
