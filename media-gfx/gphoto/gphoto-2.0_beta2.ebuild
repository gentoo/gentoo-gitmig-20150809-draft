# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>

MY_P="${PN}-`echo ${PV} |sed -e 's:_::'`"
S=${WORKDIR}/${MY_P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${MY_P}.tar.gz"
HOMEPAGE="http://www.gphoto.org/"

DEPEND="virtual/glibc
	>=dev-libs/libusb-0.1.3b
	>=dev-libs/glib-1.2.10
	>=sys-libs/zlib-1.1.3"


src_compile() {

	# -pipe does no work
	env CFLAGS="${CFLAGS/-pipe/}" ./configure		\
		--prefix=/usr					\
		--sysconfdir=/etc				\
		|| die

	cp libgphoto2/Makefile libgphoto2/Makefile.orig
	sed -e 's:$(prefix)/doc/gphoto2:/usr/share/doc/${PF}:'	\
		libgphoto2/Makefile.orig >libgphoto2/Makefile

	make || die
}

src_install() {

	make prefix=${D}/usr					\
		sysconfdir=${D}/etc				\
		gphotodocdir=${D}/usr/share/doc/${PF}		\
		HTML_DIR=${D}/usr/share/doc/${PF}/sgml		\
		install || die
	
	dodoc ChangeLog NEWS* README
	rm -rf ${D}/usr/share/doc/${PF}/sgml/gphoto2
}

