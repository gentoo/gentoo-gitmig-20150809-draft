# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author First Last <your email>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-0.7.0.ebuild,v 1.2 2002/05/27 17:27:35 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Genealogical Research and Analysis Management Programming System"

SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

HOMEPAGE="http://gramps.sourceforge.net/"

DEPEND=">=dev-lang/python-2.0
	>=gnome-base/gnome-core-1.2
	dev-python/gnome-python
	dev-python/PyXML
	dev-python/Imaging
	dev-python/ReportLab"

RDEPEND="${DEPEND}"

src_unpack() {
	
	unpack ${P}.tar.gz
	cd ${S}/src

	#Apply patch to allow compiling with python-2.2
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff

}

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man || die
	
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \	
		install || die

	dodoc COPYING NEWS README TODO
}


