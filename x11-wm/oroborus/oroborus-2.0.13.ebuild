# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.13.ebuild,v 1.13 2006/03/15 08:07:48 spyderous Exp $

DESCRIPTION="Small and fast window manager."
HOMEPAGE="http://www.oroborus.org/"
SRC_URI="http://www.oroborus.org/debian/dists/sid/main/source/x11/${P/-/_}-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc amd64 sparc"
IUSE="gnome"

RDEPEND="|| ( ( x11-libs/libXxf86vm
			x11-libs/libXpm
		)
		virtual/x11
	)"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xf86vidmodeproto
			x11-proto/xextproto
		)
		virtual/x11
	)"

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
