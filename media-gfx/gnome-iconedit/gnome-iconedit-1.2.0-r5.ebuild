# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-iconedit/gnome-iconedit-1.2.0-r5.ebuild,v 1.4 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Edits icons, what more can you say?"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="www.advogato.org/proj/GNOME-Iconedit/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.11.0-r1
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
	patch -p1 <${FILESDIR}/gnome-iconedit.diff || die

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
