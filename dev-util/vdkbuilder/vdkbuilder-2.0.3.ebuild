# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.0.3.ebuild,v 1.8 2003/12/14 22:41:32 zul Exp $
#	sdl? ( media-libs/vdksdl )
# if we figure out xdb... there's a --enable-xdb and vdkxdb

IUSE="nls gnome"

DESCRIPTION="The Visual Development Kit used for VDK Builder."
SRC_URI="mirror://sourceforge/vdkbuilder/${P}.tar.gz"
S="${WORKDIR}/${P/vdkbuilder/vdkbuilder2}"
HOMEPAGE="http://vdkbuilder.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-libs/vdk
		gnome? ( gnome-base/libgnome )"

src_compile() {

	local myconf

	# Allows vdkbuilder to compile on gcc3 systems.
	epatch ${FILESDIR}/vdkbuilder-gcc3.patch || die "Patch Failed"

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
	einstall || die
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO
}
