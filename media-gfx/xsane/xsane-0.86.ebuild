# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.77-r1.ebuild,v 1.2 2002/04/28 04:50:25 seemant Exp

S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"
HOMEPAGE="http://www.xsane.org"

DEPEND="media-gfx/sane-backends"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/man --host=${CHOST} || die
	make || die

}

src_install () {

	make prefix=${D}/usr/ mandir=${D}/usr/man install || die
	dodoc xsane.[A-Z]*
	dohtml -r doc
	
	# link xsane so it is seen as a plugin in gimp
	if [ -d /usr/lib/gimp/1.2 ]; then
		mkdir -p ${D}/usr/lib/gimp/1.2/plug-ins
		ln -sf /usr/bin/xsane ${D}/usr/lib/gimp/1.2/plug-ins
	fi
	if [ -d /usr/lib/gimp/1.3 ]; then
		mkdir -p ${D}/usr/lib/gimp/1.3/plug-ins
		ln -sf /usr/bin/xsane ${D}/usr/lib/gimp/1.3/plug-ins
	fi
}
