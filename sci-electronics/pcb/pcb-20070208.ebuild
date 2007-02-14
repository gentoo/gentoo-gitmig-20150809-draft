# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/pcb/pcb-20070208.ebuild,v 1.1 2007/02/14 19:33:13 calchan Exp $

inherit eutils

DESCRIPTION="tool for the layout of printed circuit boards"
HOMEPAGE="http://pcb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="gif jpeg png"

RDEPEND=">=x11-libs/gtk+-2.4
	gif? ( media-libs/gd )
	jpeg? ( media-libs/gd )
	png? ( media-libs/gd )"
DEPEND="${RDEPEND}
	=dev-lang/tk-8*
	|| (
		virtual/x11
		x11-proto/xproto
	   )
	dev-util/pkgconfig"

pkg_setup() {
	if use jpeg ; then
		built_with_use media-libs/gd jpeg || die "You need to emerge media-libs/gd with USE=jpeg"
	fi
	if use png ; then
		echo "Using png"
		built_with_use media-libs/gd png || die "You need to emerge media-libs/gd with USE=png"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' doc/pcb.info || die "sed failed"
}

src_compile() {
	local EXPORTERS
	if (use gif) || (use jpeg) || (use png) ; then
		EXPORTERS="bom gerber png ps"
	else
		EXPORTERS="bom gerber ps"
	fi
	econf \
		--disable-dependency-tracking \
		$(use_enable gif ) \
		$(use_enable jpeg ) \
		$(use_enable png ) \
		--with-exporters="${EXPORTERS}" \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
	newicon win32/pcb_icon_big.xpm pcb.xpm
	make_desktop_entry pcb PCB pcb.xpm Electronics
}
