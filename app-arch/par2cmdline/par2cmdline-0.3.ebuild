# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par2cmdline/par2cmdline-0.3.ebuild,v 1.1 2003/11/15 02:09:13 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A PAR-2.0 file verification and repair tool"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	local DOCLIST="AUTHORS INSTALL COPYING ChangeLog NEWS PORTING README ROADMAP"
	chmod -x ${DOCLIST}
	dodoc ${DOCLIST}
}

pkg_postinst() {
	einfo "Use (<par2create|par2 c> archive) to create PAR2 archive"
	einfo "Use (<par2verify|par2 v> archive) to verify PAR2 archive"
	einfo "Use (<par2repair|par2 r> archive) to repair PAR2 archive"
}
