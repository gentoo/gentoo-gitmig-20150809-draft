# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grsync/grsync-0.5-r1.ebuild,v 1.2 2006/10/21 08:48:21 dertobi123 Exp $

inherit eutils gnome2 autotools

DESCRIPTION="A gtk frontend to rsync"
HOMEPAGE="http://www.opbyte.it/grsync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="doc"
SRC_URI="http://www.opbyte.it/release/${P}.tar.gz"

RDEPEND=">=x11-libs/gtk+-2.6
	net-misc/rsync"

DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS NEWS README"

src_unpack() {
	gnome2_src_unpack

	# Fix localization
	cd ${S}
	epatch ${FILESDIR}/${P}-intltool.patch
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf
}
