# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pspresent/pspresent-1.1.ebuild,v 1.3 2003/12/09 17:44:09 lanius Exp $

IUSE="xinerama"

S="${WORKDIR}/${P}"
DESCRIPTION="A tool to display full-screen PostScript presentations."
SRC_URI="http://www.cse.unsw.edu.au/~matthewc/pspresent/${P}.tar.gz"
HOMEPAGE="http://www.cse.unsw.edu.au/~matthewc/pspresent/"

DEPEND="virtual/glibc
	virtual/x11
	>=sys-apps/sed-4
	virtual/ghostscript"
RDEPEND="virtual/glibc
	virtual/x11
	virtual/ghostscript"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile()
{
	if [ ! "`use xinerama`" ] ; then
		sed -i -e "/^XINERAMA/s/^/#/g" Makefile
	fi
	make pspresent || die "make failed"
}

src_install()
{
	dobin pspresent
	doman pspresent.1
	dodoc COPYING
}
