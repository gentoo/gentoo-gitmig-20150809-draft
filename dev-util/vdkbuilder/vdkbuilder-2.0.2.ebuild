# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.0.2.ebuild,v 1.1 2002/06/19 23:40:54 bass Exp $

S="${WORKDIR}/vdk-2.0.2"
DESCRIPTION="A RAD Application Development tool based on VDK (The Visual Development Kit)."
SRC_URI="mirror://sourceforge/vdkbuilder/vdk-2.0.2.tar.gz"
HOMEPAGE="vdkbuilder.sf.net"
LICENSE="GPL-2"
DEPEND="dev-libs/atk
		x11-libs/pango
		dev-libs/glib
		dev-util/pkgconfig
		x11-libs/gtk+
		app-doc/doxygen"
RDEPEND="${DEPEND}"
SLOT="0"

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
