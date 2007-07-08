# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/katoob/katoob-0.3.8.ebuild,v 1.6 2007/07/08 00:20:48 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Small text editor based on the GTK+ library 2.0"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=katoob"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="debug spell"

RDEPEND="spell? ( app-text/aspell )
	>=x11-libs/gtk+-2
	>=x11-libs/gtksourceview-0.2
	>=x11-libs/pango-1"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.18
	dev-util/pkgconfig"

src_compile() {
	local myconf="--enable-highlight"

	use debug && myconf="${myconf} --enable-debug --disable-release"
	use spell && myconf="${myconf} --enable-spell"

	econf ${myconf} || die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README RELEASE_NOTES THANKS TODO
}
