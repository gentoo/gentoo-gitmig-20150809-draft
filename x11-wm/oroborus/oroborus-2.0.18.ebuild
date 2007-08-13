# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.18.ebuild,v 1.5 2007/08/13 22:09:57 dertobi123 Exp $

DESCRIPTION="Small and fast window manager."
HOMEPAGE="http://www.oroborus.org/"
SRC_URI="http://www.oroborus.org/debian/dists/sid/main/source/x11/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc ~x86"
IUSE="gnome"

RDEPEND="x11-libs/libXxf86vm
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto"

src_compile() {
	aclocal
	autoheader
	automake --add-missing
	autoconf
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/X11/oroborus \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/oroborus \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die

	if use gnome ; then
		insinto /usr/share/gnome/wm-properties
		doins ${FILESDIR}/oroborus.desktop
	fi

	dodoc README INSTALL ChangeLog TODO AUTHORS example.oroborusrc
}
