# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.15.2-r1.ebuild,v 1.3 2002/08/01 18:02:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="http://download.sourceforge.net/librep/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
	readline? ( >=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2 )
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}

	cd ${S}
	#patch buggy makefile for newer libtool
	patch -p1 <${FILESDIR}/librep-${PV}-exec.patch || die

	#update libtool to fix "relink" bug
	libtoolize --copy --force
	aclocal
}

src_compile() {
	local myconf

	use readline \
		&& myconf="--with-readline" \
		|| myconf="--without-readline"

	econf --libexecdir=/usr/lib  || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/include
	doins src/rep_config.h
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
	docinto doc
	dodoc doc/*
}
