# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx-base/lyx-base-1.1.6.4-r1.ebuild,v 1.1 2002/02/21 00:03:17 agriffis Exp $

# The real version of LyX is 1.1.6fix4. As Portage has no support for
# arbitrary suffixes like 'fix', this is translated into 1.1.6.4.
P=lyx-1.1.6fix4
S=${WORKDIR}/${P}
DESCRIPTION="LyX is an WYSIWYM frontend for LaTeX"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.gz"
HOMEPAGE="http://www.lyx.org/"

# This lyx-base ebuild only depends on the absolutely necessary packages.
# The acompanying lyx-utils ebuild depends on lyx-base and on everything
# else that lyx can use.
DEPEND="virtual/x11
	x11-libs/xforms
	app-text/tetex 
	>=sys-devel/perl-5
	sys-devel/gcc
	sys-libs/glibc
	sys-devel/ld.so"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir='$(prefix)/share/info' \
		--mandir='$(prefix)/share/man' || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	# The 'install-strip' target is provided by the LyX makefile
	# for stripping installed binaries.  Use prefix= instead of
	# DESTDIR=, otherwise it violates the sandbox in the po directory.
	make prefix=${D}/usr install-strip
}
