# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-0.7.0.ebuild,v 1.10 2003/02/13 09:00:51 vapier Exp $

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"
HOMEPAGE="http://gramps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.0
	<=gnome-base/gnome-panel-1.5
	dev-python/gnome-python
	dev-python/PyXML
	dev-python/Imaging
	dev-python/ReportLab"

src_unpack() {
	unpack ${A}
	cd ${S}/src

	#Apply patch to allow compiling with python-2.2
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc COPYING NEWS README TODO
}
