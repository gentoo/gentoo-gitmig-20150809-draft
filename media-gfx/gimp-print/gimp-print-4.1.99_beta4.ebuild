# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

MY_P="${PN}-`echo ${PV} |sed -e 's:_:-:' -e 's:eta::'`"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gimp Plugin and Ghostscript driver for Gimp"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.gz"
HOMEPAGE="http://gimp-print.sourceforge.net/"

DEPEND=">=media-gfx/gimp-1.2.1"

RDEPEND="virtual/glibc"


src_compile() {

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc/gimp/1.2/				\
		    --with-gimp-exec-prefix=/usr			\
		    || die

	cp src/gimp/Makefile src/gimp/Makefile.orig
	sed -e 's:--install-admin-bin:--install-bin:g'			\
		src/gimp/Makefile.orig >src/gimp/Makefile

	make || die
}

src_install() {

	dodir /usr/lib/gimp/1.2/.gimp-1.2/plug-ins

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc/gimp/1.2/				\
	     HOME=${D}/usr/lib/gimp/1.2/				\
	     install || die

	# NOTE: this build use gimptool to install the plugin, so
	# if we dont do it this way, it will install to / no
	# matter what.
	mv ${D}/usr/lib/gimp/1.2/.gimp-1.2/plug-ins/			\
		${D}/usr/lib/gimp/1.2/
	rm -rf ${D}/usr/lib/gimp/1.2/.gimp-1.2/
	     
	dodoc AUTHORS ChangeLog COPYING NEWS README*
}

