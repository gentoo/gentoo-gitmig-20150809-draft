# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.9-r3.ebuild,v 1.10 2007/05/13 03:03:35 matsuu Exp $

inherit eutils

DESCRIPTION="Indent program source files"
HOMEPAGE="http://www.gnu.org/software/indent/indent.html"
SRC_URI="mirror://gnu/indent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-deb-gentoo.patch
	epatch "${FILESDIR}"/${PV}-malloc.patch
	epatch "${FILESDIR}"/${PV}-indent-off-segfault.patch # #125648

	# Update timestamp so it isn't regenerated #76610
	touch -r man/Makefile.am man/texinfo2man.c
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README*
	dohtml "${D}"/usr/doc/indent/*
	rm -r "${D}"/usr/doc
}
