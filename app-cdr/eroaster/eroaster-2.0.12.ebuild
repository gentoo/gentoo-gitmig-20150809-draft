# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.0.12.ebuild,v 1.8 2004/03/12 11:51:42 mr_bones_ Exp $

DESCRIPTION="Awesome CD burning frontend"
SRC_URI="ftp://eclipt.uni-klu.ac.at/pub/projects/eroaster/${P}.tar.gz"
HOMEPAGE="http://eclipt.uni-klu.ac.at/eroaster.php"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND=">=dev-lang/python-2.0
	app-cdr/cdrtools
	dev-python/gnome-python"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
