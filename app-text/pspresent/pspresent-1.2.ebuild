# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pspresent/pspresent-1.2.ebuild,v 1.2 2005/03/22 09:32:32 usata Exp $

IUSE="xinerama"

DESCRIPTION="A tool to display full-screen PostScript presentations."
SRC_URI="http://www.cse.unsw.edu.au/~matthewc/pspresent/${P}.tar.gz"
HOMEPAGE="http://www.cse.unsw.edu.au/~matthewc/pspresent/"

RDEPEND="virtual/libc
	virtual/x11
	virtual/ghostscript"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PROVIDE="virtual/psviewer"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile()
{
	if ! use xinerama ; then
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
