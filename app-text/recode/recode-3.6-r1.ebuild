# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6-r1.ebuild,v 1.12 2004/09/15 16:11:02 gmsoft Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Convert files between various character sets"
HOMEPAGE="http://www.gnu.org/software/recode/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-debian.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha amd64 ia64 hppa"
IUSE="nls"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-debian.diff
}

src_compile() {
	# gcc-3.2 crashes if we don't remove any -O?
	[ "`gcc-version`" == "3.2" ] && [ ${ARCH} == "x86" ] \
		&& filter-flags -O?
	replace-cpu-flags pentium3 pentium4

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BACKLOG ChangeLog INSTALL NEWS README THANKS TODO
}
