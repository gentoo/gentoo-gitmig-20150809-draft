# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog-lite/swi-prolog-lite-5.1.13.ebuild,v 1.1 2003/05/23 09:26:57 pauldv Exp $

DESCRIPTION="free, small, and standard compliant a Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://www.swi.psy.uva.nl/cgi-bin/nph-download/SWI-Prolog/BETA/pl-${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="readline static"

DEPEND="readline? ( sys-libs/readline )
	sys-libs/ncurses
	virtual/glibc
	sys-apps/gawk
	sys-apps/sed
	sys-devel/binutils"
S="${WORKDIR}/pl-${PV}"

src_compile() {
	# fix install destinations
	patch -p0 < ${FILESDIR}/destdir.patch

	local myconf=""			# multithread is beta right now --enable-mt
	use readline \
		&& myconf="${myconf} --enable-readline" \
		|| myconf="${myconf} --disable-readline"
	use static && myconf="${myconf} --disable-shared"

	econf ${myconf} --enable-mt
	make || die "make failed"	# emake doesnt work
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	rm -rf ${D}/usr/share/man/man3/readline.3

	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README VERSION
}
