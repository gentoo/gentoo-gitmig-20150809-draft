# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-iconedit/gnome-iconedit-1.2.0-r5.ebuild,v 1.15 2004/01/26 00:28:16 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Edits icons, what more can you say?"
HOMEPAGE="http://www.advogato.org/proj/GNOME-Iconedit/"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.11.0-r1
	dev-libs/libxml
	media-libs/libpng
	gnome-base/ORBit"
# Gnome-Print support is broken
#	>=gnome-base/gnome-print-0.30
# Bonobo support is broken
#	bonobo? ( gnome-base/bonobo )"

src_unpack() {
	unpack ${A}

	# Fix some compile / #include errors
	cd ${S}
	epatch ${FILESDIR}/gnome-iconedit.diff

	# Update the Makefiles.
	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.1
	automake --add-missing
	autoconf
}

src_compile() {
	append-flags `gnome-config --cflags print` -I/usr/include/gdk-pixbuf-1.0
	econf \
		--without-gnome-print \
		`use_enable nls` \
		|| die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
