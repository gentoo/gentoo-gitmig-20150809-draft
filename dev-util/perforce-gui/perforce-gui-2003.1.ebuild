# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit rpm

DESCRIPTION="GUI for commercial version control system"
HOMEPAGE="http://www.perforce.com/"
URI_BASE="ftp://ftp.perforce.com/perforce/r03.1/"
GUI_BASE="$URI_BASE/bin.linux72x86"
GUI_NAME="p4v-2003.1-48707.i386"
GUI_RPM="${GUI_NAME}.rpm"
DOC_BASE="$URI_BASE/doc"
SRC_URI="${GUI_BASE}/${GUI_RPM}"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"
MY_FILES=$FILESDIR/perforce-2003.1/

src_install()
{
	cp -R ${WORKDIR}/usr ${D}
}
