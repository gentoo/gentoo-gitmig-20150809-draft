# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/ReportLab/ReportLab-1.11.ebuild,v 1.4 2002/08/16 02:49:58 murphy Exp $

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

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

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




