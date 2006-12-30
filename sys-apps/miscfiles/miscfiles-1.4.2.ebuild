# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.4.2.ebuild,v 1.3 2006/12/30 02:12:57 vapier Exp $

inherit eutils

DESCRIPTION="Miscellaneous files"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"
SRC_URI="ftp://ftp.gnu.org/gnu/miscfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="minimal"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/miscfiles-1.3-Makefile.diff
}

src_install() {
	emake install prefix="${D}/usr" || die
	dodoc GNU* NEWS ORIGIN README dict-README
	rm -f "${D}"/usr/share/dict/README

	if use minimal ; then
		cd "${D}"/usr/share/dict
		rm -f words extra.words
		gzip -9 *
		ln -s web2.gz words
		ln -s web2a.gz extra.words
		ln -s connectives{.gz,}
		ln -s propernames{.gz,}
		cd ..
		rm -r misc rfc
	fi
}
