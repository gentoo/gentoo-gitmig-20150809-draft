# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.86-r1.ebuild,v 1.3 2002/09/14 03:12:44 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"
HOMEPAGE="http://www.xsane.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="media-gfx/sane-backends =x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use jpeg || myconf="${myconf} --disable-jpeg"
	use png || myconf="${myconf} --disable-png"
	use tiff || myconf="${myconf} --disable-tiff"

	econf ${myconf} || die
	make || die
}

src_install () {
	einstall || die
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
