# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.2.ebuild,v 1.2 2002/07/21 03:07:46 seemant Exp $ 

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="A GNOME2 radio tuner"
SRC_URI="http://mfcn.ilo.de/gnomeradio/${P}.tar.gz"
HOMEPAGE="http://mfcn.ilo.de/gnomeradio/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/gnome-vfs-2.0.1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/bonobo-activation-1.0.2
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.1"

RDEPEND="${DEPEND} >=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf
		--localstatedir=/var/lib \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "install failed"
    
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO
}
