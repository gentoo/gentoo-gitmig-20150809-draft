# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# # $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.16.ebuild,v 1.9 2003/09/06 22:29:24 msterret Exp $

IUSE="readline"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://librep.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
	readline? (	>=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2 )
	sys-apps/texinfo
	>=sys-devel/automake-1.6.1-r5"

src_compile() {
	elibtoolize

	local myconf=""
	use readline \
		&& myconf="--with-readline" \
		|| myconf="--without-readline"

	LC_ALL=""
	LINGUAS=""
	LANG=""
	export LC_ALL LINGUAS LANG

	econf \
		--libexecdir=/usr/lib \
		--with-extra-cflags=-fstrength-reduce \
		${myconf} || die "configure failure"

	emake host_type=${CHOST} || die "compile failure"
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
