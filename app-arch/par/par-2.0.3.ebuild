# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par/par-2.0.3.ebuild,v 1.2 2003/11/11 13:08:39 vapier Exp $

MY_PN="par2cmdline"
MY_PV="${PV/2./}"
MY_P="${MY_PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="a PAR-2.0 and PAR-1 compatible file verification and repair tool"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
	dosym /usr/bin/par2 /usr/bin/par
	dosym /usr/bin/par2create /usr/bin/parcreate
	dosym /usr/bin/par2verify /usr/bin/parverify
	dosym /usr/bin/par2repair /usr/bin/parrepair
}

pkg_postinst() {
	einfo "Use (<par{,2}create|par{,2} c> archive) to create archive"
	einfo "Use (<par{,2}verify|par{,2} v> archive) to verify archive"
	einfo "Use (<par{,2}repair|par{,2} r> archive) to repair archive"
}
