# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Spider <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/librep/librep-0.15.2.ebuild,v 1.1 2002/01/23 18:45:25 azarah Exp

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

MY_P=${PN}-2002-05-02
S=${WORKDIR}/${MY_P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://librep.sourceforge.net/"

DEPEND="virtual/glibc
	>=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
	readline? (	>=sys-libs/readline-4.1
			>=sys-libs/ncurses-5.2 )
	sys-apps/texinfo"

src_compile() {
	local myconf

	if [ "`use readline`" ] ; then
		myconf="--with-readline"
	else
		myconf="--without-readline"
	fi

	./configure --host=${CHOST} \
			${myconf} \
		    --prefix=/usr \
		    --libexecdir=/usr/lib \
		    --infodir=/usr/share/info || die

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
