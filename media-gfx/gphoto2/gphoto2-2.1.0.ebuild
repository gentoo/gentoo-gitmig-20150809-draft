# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.1.0.ebuild,v 1.1 2002/10/23 18:42:43 spider Exp $

inherit libtool

MY_P=${PN}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/gphoto/${MY_P}.tar.gz"
HOMEPAGE="http://www.gphoto.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-libs/libusb-0.1.6
	=dev-libs/glib-1.2*
	>=sys-libs/zlib-1.1.4"

src_compile() {

	elibtoolize
	aclocal

	# -pipe does no work
	env CFLAGS="${CFLAGS/-pipe/}" ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		|| die

	cp libgphoto2/Makefile libgphoto2/Makefile.orig
	sed -e 's:$(prefix)/doc/gphoto2:/usr/share/doc/${PF}:' \
		libgphoto2/Makefile.orig >libgphoto2/Makefile

	make || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		gphotodocdir=${D}/usr/share/doc/${PF} \
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml \
		install || die

	dodoc ChangeLog NEWS* README
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
