# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.1.1.ebuild,v 1.2 2002/11/11 05:29:10 nall Exp $

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen."
HOMEPAGE="http://ratpoison.sourceforge.net"
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ppc"

IUSE="X"

DEPEND=">=xfree-4.2.0-r12"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
	#make || die
}

src_install() {
	make DESTDIR=${D} install || die
	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
}
