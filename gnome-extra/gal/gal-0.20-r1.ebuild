# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-0.20-r1.ebuild,v 1.5 2003/03/08 18:58:18 foser Exp $

IUSE="nls alsa"

inherit gnome.org libtool

S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/python
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11
	sys-devel/perl
    <gnome-base/gnome-vfs-1.9.0
	>=dev-libs/libunicode-0.4-r1
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	>=gnome-base/gnome-print-0.34
	=gnome-base/libglade-0*
	>=dev-libs/libxml-1.8.16
	media-libs/gdk-pixbuf"


src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST}	\
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		     ${myconf} || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib	\
	     install || die

	# Add some type of backward compat...
	local fullname=$(python -c "import os; \
		print os.path.realpath(\"${D}/usr/lib/libgal.so\")")
	dosym ${fullname##*/} /usr/lib/libgal.so.$((${PV##*.}-1))

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

