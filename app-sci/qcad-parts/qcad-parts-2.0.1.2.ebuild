# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qcad-parts/qcad-parts-2.0.1.2.ebuild,v 1.5 2004/10/17 10:46:27 absinthe Exp $

MY_PN="partlibrary"
MY_PV="${PV}-1"

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
HOMEPAGE="http://www.ribbonsoft.com/qcad_library.html"
SRC_URI="http://www.ribbonsoft.com/archives/partlibrary/partlibrary-${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	einfo "Will unpack when installing"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	mkdir -p ${D}/usr/share/${PF}
	cd ${D}/usr/share/${PF}
	unpack ${A}
	mv partli*/* .
	rmdir partlib*
	einfo "Adjusting permissions..."
	chown -R root:root .
	find . -type d -not -perm -005 | while read dir; do
		echo "Fixing directory $dir"; chmod ugo+rx $dir; done
	find . -type f -not -perm -004 | while read file; do
		echo "Fixing file $file"; chmod ugo+r $file; done
}

pkg_postinst() {
	einfo
	einfo "The QCad parts library was installed in"
	einfo "/usr/share/${PF}"
	einfo "Please set this path in QCad's preferences to access it."
	einfo "(Edit->Application Preferences->Paths->Part Libraries)"
	einfo
	einfo "After restarting QCad, you can use the library by selecting"
	einfo "View->Views->Library Browser"
	einfo
}
