# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par2cmdline/par2cmdline-0.4.ebuild,v 1.9 2004/11/17 17:05:14 vapier Exp $

DESCRIPTION="A PAR-2.0 file verification and repair tool"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc-macos x86"
IUSE=""

DEPEND=""

src_install() {
	make install DESTDIR="${D}" || die
	local DOCLIST="AUTHORS INSTALL ChangeLog NEWS PORTING README ROADMAP"
	chmod -x ${DOCLIST}
	dodoc ${DOCLIST}
}
