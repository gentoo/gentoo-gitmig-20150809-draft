# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.0.2.ebuild,v 1.5 2002/08/16 04:04:42 murphy Exp $

MY_P=${P/builder/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A RAD Application Development tool based on VDK (The Visual Development Kit)."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://vdkbuilder.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="dev-libs/atk
	x11-libs/pango
	dev-libs/glib
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.0.3
	app-doc/doxygen
	gnome? ( gnome-base/libgnome )"

src_compile() {

    local myconf
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use gnome \
		&& myconf="${myconf} --enable-gnome=yes" \
		|| myconf="${myconf} --enable-gnome=no"
							  
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO
}
