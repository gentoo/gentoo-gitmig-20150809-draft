# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/dev-python/Numeric/Numeric-19.0.0.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp

#goofy tarball versioning
vmaj=${PV%%.*}
vmin=${PV##*.}

S=${WORKDIR}/reportlab
DESCRIPTION="Tools for generating printable PDF documents from any data source."
SRC_URI="http://www.reportlab.com/ftp/${PN}_${vmaj}_${vmin}.tgz"
HOMEPAGE="http://www.reportlab.com/"

DEPEND=">=dev-lang/python-2.0
	>=sys-libs/zlib-0.95
	dev-python/Imaging"

RDEPEND=${DEPEND}

src_install() {

	#grab python verision so ebuild doesn't depend on it
	local pv
	pv=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	
	
	insinto /usr/lib/python$pv/site-packages
	echo "reportlab" > reportlab.pth
	doins reportlab.pth
	#I'm feeling lazy
	cd ../
	cp -a reportlab ${D}/usr/lib/python$pv/site-packages
	
	cd ${S}
	dodoc  README license.txt

}




