# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/xmps/xmps-0.2.0-r1.ebuild,v 1.7 2002/09/11 20:55:21 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X Movie Player System"
SRC_URI="http://xmps.sourceforge.net/sources/${P}.tar.gz"
HOMEPAGE="http://xmps.sourceforge.net"

DEPEND="=x11-libs/gtk+-1.2*
	x86? ( >=dev-lang/nasm-0.98 )
	>=dev-libs/popt-1.5
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

RDEPEND=">=media-libs/smpeg-0.4.4-r1
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf

	use gnome && myconf="--enable-gnome"

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die

	cp Makefile Makefile.orig
	sed -e "s:\$(bindir)/xmps-config:\$(DESTDIR)\$(bindir)/xmps-config:" \
		Makefile.orig > Makefile

	make || die

}

src_install () {

	einstall || die

	dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}
