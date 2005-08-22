# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.17-r1.ebuild,v 1.4 2005/08/22 18:35:10 gustavoz Exp $

IUSE="readline"

inherit libtool toolchain-funcs

DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"

RDEPEND=">=sys-libs/gdbm-1.8.0
	readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}
	sys-apps/texinfo
	>=sys-devel/automake-1.6.1-r5"

src_compile() {
	elibtoolize

	local myconf

	use readline \
		&& myconf='--with-readline' \
		|| myconf='--without-readline'
	use ppc && myconf="${myconf} --with-stack-direction=1"
	LC_ALL=""
	LINGUAS=""
	LANG=""
	export LC_ALL LINGUAS LANG

	CC=$(tc-getCC) econf \
		--libexecdir=/usr/lib \
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

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC TREE
	docinto doc
	dodoc doc/*
}
