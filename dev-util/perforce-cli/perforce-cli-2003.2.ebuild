# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perforce-cli/perforce-cli-2003.2.ebuild,v 1.2 2004/04/26 01:39:44 vapier Exp $

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
RESTRICT="nomirror nostrip"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4 p4.1 ; do
		cp ${DISTDIR}/$x .
	done
}

src_install() {
	dobin p4 || die
	doman p4.1
}
