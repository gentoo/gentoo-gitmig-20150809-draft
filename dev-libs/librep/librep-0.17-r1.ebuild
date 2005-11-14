# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.17-r1.ebuild,v 1.8 2005/11/14 07:56:59 truedfx Exp $

IUSE="readline"

inherit eutils libtool toolchain-funcs multilib

DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

RDEPEND=">=sys-libs/gdbm-1.8.0
	readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}
	sys-apps/texinfo
	>=sys-devel/automake-1.6.1-r5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/rep_file_fdopen.patch"
}

src_compile() {
	elibtoolize

	local myconf="$(use_with readline)"
	use ppc && myconf="${myconf} --with-stack-direction=1"
	LC_ALL=""
	LINGUAS=""
	LANG=""
	export LC_ALL LINGUAS LANG

	CC=$(tc-getCC) econf \
		--libexecdir=/usr/$(get_libdir) \
		--without-gmp \
		--without-ffi \
		${myconf} || die "configure failure"

	make host_type=${CHOST} || die "compile failure"
}

src_install() {
	make install \
		host_type=${CHOST} \
		DESTDIR=${D} \
		aclocaldir=/usr/share/aclocal \
		infodir=/usr/share/info || die

	insinto /usr/include
	doins src/rep_config.h

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO DOC TREE
	docinto doc
	dodoc doc/*
}
