# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="CLI Tools for a commercial version control system"
HOMEPAGE="http://www.perforce.com/"
URI_BASE="ftp://ftp.perforce.com/perforce/r03.2/"
BIN_BASE="$URI_BASE/bin.linux24x86"
DOC_BASE="$URI_BASE/doc"
SRC_URI="${BIN_BASE}/p4 ${DOC_BASE}/man/p4.1"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"
MY_FILES=$FILESDIR/perforce-2003.1/

src_unpack ()
{
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4 p4.1 ; do
		cp ${DISTDIR}/$x .
	done
}

src_install()
{
	dobin  p4
	doman p4.1
}
