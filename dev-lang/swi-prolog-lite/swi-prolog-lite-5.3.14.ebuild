# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog-lite/swi-prolog-lite-5.3.14.ebuild,v 1.3 2004/10/23 06:07:00 mr_bones_ Exp $

IUSE="readline static"

S="${WORKDIR}/pl-${PV}"
DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://www.swi.psy.uva.nl/cgi-bin/nph-download/SWI-Prolog/BETA/pl-5.3.14.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc-macos"

DEPEND="sys-libs/ncurses
	sys-apps/gawk
	sys-apps/sed
	virtual/libc
	readline? ( sys-libs/readline )"

src_compile() {
	cd ${S}/src
	#S="${S}/src"

	local myconf
	use readline || myconf="${myconf} --disable-readline"
	use static && myconf="${myconf} --disable-shared"

	econf ${myconf} --enable-mt || die "econf failed"
	MAKEOPTS="-j1" emake || die "make failed"
}

src_install() {
	cd ${S}/src
	einstall

	cd ${S}
	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README VERSION
}
