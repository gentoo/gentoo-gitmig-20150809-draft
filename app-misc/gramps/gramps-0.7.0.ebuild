# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-0.7.0.ebuild,v 1.4 2002/07/25 17:20:00 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Genealogical Research and Analysis Management Programming System"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"
HOMEPAGE="http://gramps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.0
	>=gnome-base/gnome-core-1.2
	dev-python/gnome-python
	dev-python/PyXML
	dev-python/Imaging
	dev-python/ReportLab"

src_unpack() {
	
	unpack ${P}.tar.gz
	cd ${S}/src

	#Apply patch to allow compiling with python-2.2
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die

}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc COPYING NEWS README TODO
}
