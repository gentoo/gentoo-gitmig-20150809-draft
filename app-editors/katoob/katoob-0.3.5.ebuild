# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/katoob/katoob-0.3.5.ebuild,v 1.4 2004/04/25 22:03:20 agriffis Exp $

inherit eutils

DESCRIPTION="Small text editor based on the GTK+ library 2.0"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=katoob"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="debug spell"

DEPEND=">=x11-libs/gtk+-2
	x11-libs/gtksourceview"
RDEPEND="spell? ( app-text/aspell )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-misc_fixes.patch
}

src_compile() {
	local myconf="--enable-highlight"

	use debug && myconf="${myconf} --enable-debug"
	use spell && myconf="${myconf} --enable-spell"

	econf ${myconf} || die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING GPL.ar NEWS README RELEASE_NOTES \
		THANKS TODO
}

