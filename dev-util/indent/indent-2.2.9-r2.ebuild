# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.9-r2.ebuild,v 1.5 2006/07/05 05:37:55 vapier Exp $

inherit eutils

DESCRIPTION="Indent program source files"
HOMEPAGE="http://www.gnu.org/software/indent/indent.html"
SRC_URI="mirror://gnu/indent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-deb-gentoo.patch
	epatch "${FILESDIR}"/${PV}-malloc.patch

	# Update timestamp so it isn't regenerated #76610
	touch -r man/Makefile.am man/texinfo2man.c
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README*
	dohtml "${D}"/usr/doc/indent/*
	rm -r "${D}"/usr/doc
}
