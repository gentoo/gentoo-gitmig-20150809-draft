# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.3-r1.ebuild,v 1.13 2004/11/12 21:16:55 vapier Exp $

inherit eutils

DESCRIPTION="Miscellaneous files"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="uclibc"

DEPEND="uclibc? ( app-arch/gzip )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/tasks.info.diff
	epatch ${FILESDIR}/${P}-Makefile.diff
}

src_install() {
	einstall || die
	dodoc GNU* NEWS ORIGIN README dict-README

	if use uclibc ; then
		cd ${D}/usr/share/dict
		# need to remove the hardlinks, else gzip won't work
		rm -f words extra.words README
		gzip -9 *
		ln -s web2.gz words
		ln -s web2a.gz extra.words
		cd ..
		# which app uses these?
		rm -rf misc state rfc
		#rm -f misc/GNU-manifesto
		#gzip -9 misc/* state/* rfc/*
		cd ${S}
	fi
}
