# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6-r1.ebuild,v 1.18 2004/11/07 14:45:58 corsair Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Convert files between various character sets"
HOMEPAGE="http://www.gnu.org/software/recode/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-debian.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86 ppc64"
IUSE="nls"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-debian.diff"
}

src_compile() {
	# gcc-3.2 crashes if we don't remove any -O?
	[ "$(gcc-version)" == "3.2" ] && [ ${ARCH} == "x86" ] \
		&& filter-flags -O?
	replace-cpu-flags pentium4 pentium3

	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BACKLOG ChangeLog NEWS README THANKS TODO
}
