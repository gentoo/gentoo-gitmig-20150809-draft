# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnusound/gnusound-0.6.2.ebuild,v 1.5 2004/11/23 02:55:21 eradicator Exp $

IUSE="libsamplerate"

inherit gnuconfig eutils

DESCRIPTION="GNUsound is a sound editor for Linux/x86"
HOMEPAGE="http://gnusound.sourceforge.net/"
SRC_URI="http://gnusound.sourceforge.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# -amd64, -sparc: 0.6.2 - eradicator - segfault on startup
KEYWORDS="-amd64 x86 -sparc"

DEPEND=">=gnome-base/libglade-2.0.1
	gnome-base/gnome-libs
	>=gnome-base/libgnomeui-2.2.0.1
	>=media-libs/audiofile-0.2.3
	libsamplerate? ( media-libs/libsamplerate )"

src_unpack() {
	unpack ${A} || die "unpack failure"
	cd ${S} || die "workdir not found"
	rm -f doc/Makefile || die "could not remove doc Makefile"
	rm -f modules/Makefile || die "could not remove modules Makefile"
	sed -i "s:docrootdir:datadir:" doc/Makefile.in

	# Bug #54980
	epatch ${FILESDIR}/${P}-gtkdep.patch

	# Bug #68345
	epatch ${FILESDIR}/${P}-gcc34.patch

	epatch ${FILESDIR}/${P}-destdir.patch

	gnuconfig_update
}

src_compile() {
	econf `use_with libsamplerate` --enable-optimization || die "Configure failure"
	emake || die "Make failure"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README NOTES TODO CHANGES
}
