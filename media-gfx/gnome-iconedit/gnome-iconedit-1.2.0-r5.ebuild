# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-iconedit/gnome-iconedit-1.2.0-r5.ebuild,v 1.12 2003/04/25 16:48:59 foser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Edits icons, what more can you say?"
HOMEPAGE="http://www.advogato.org/proj/GNOME-Iconedit/"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

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
	export WANT_AUTOMAKE_1_4=1
	export WANT_AUTOCONF_2_1=1
	automake --add-missing
	autoconf
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	
	CFLAGS="${CFLAGS} `gnome-config --cflags print` -I/usr/include/gdk-pixbuf-1.0"	

	econf \
		--without-gnome-print \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
