# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lwp/lwp-1.9.ebuild,v 1.5 2003/06/22 05:10:31 seemant Exp $

DESCRIPTION="Light weight process library (used by Coda).  This is NOT libwww-perl."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	# does not seems to consistently use DESTDIR where it needs to, but I could be wrong too
	# make DESTDIR=${D} install || die
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		oldincludedir=${D}/usr/include \
		install || die
}
