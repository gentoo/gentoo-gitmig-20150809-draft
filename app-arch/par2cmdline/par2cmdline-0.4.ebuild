# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par2cmdline/par2cmdline-0.4.ebuild,v 1.8 2004/10/23 08:11:43 mr_bones_ Exp $

DESCRIPTION="A PAR-2.0 file verification and repair tool"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64 ~ppc ppc-macos"

DEPEND=""

src_install() {
	einstall || die
	local DOCLIST="AUTHORS INSTALL ChangeLog NEWS PORTING README ROADMAP"
	chmod -x ${DOCLIST}
	dodoc ${DOCLIST}
}

pkg_postinst() {
	einfo "Use (<par2create|par2 c> archive) to create PAR2 archive"
	einfo "Use (<par2verify|par2 v> archive) to verify PAR2 archive"
	einfo "Use (<par2repair|par2 r> archive) to repair PAR2 archive"
}
