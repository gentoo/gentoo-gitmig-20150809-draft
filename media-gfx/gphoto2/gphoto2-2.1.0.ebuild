# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.1.0.ebuild,v 1.5 2003/08/07 03:45:37 vapier Exp $

inherit libtool
inherit flag-o-matic

MY_P=${PN}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND=">=dev-libs/libusb-0.1.6
	=dev-libs/glib-1.2*
	>=sys-libs/zlib-1.1.4"

src_compile() {
	elibtoolize
	aclocal

	# -pipe does no work
	filter-flags -pipe

	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf}

	cp libgphoto2/Makefile libgphoto2/Makefile.orig
	sed -e 's:$(prefix)/doc/gphoto2:/usr/share/doc/${PF}:' \
		libgphoto2/Makefile.orig >libgphoto2/Makefile

	make || die
}

src_install() {

	einstall
		gphotodocdir=${D}/usr/share/doc/${PF} \
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml \
		|| die

	dodoc ChangeLog NEWS* README
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}
