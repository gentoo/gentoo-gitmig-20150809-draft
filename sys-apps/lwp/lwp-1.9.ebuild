# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lwp/lwp-1.9.ebuild,v 1.1 2002/07/23 21:43:52 lostlogic Exp $

DESCRIPTION="Light weight process library (used by Coda). This is NOT libwww-perl."

# Appearantly maintained by the Coda people
HOMEPAGE="http://www.coda.cs.cmu.edu"

#actually "GNU Library General Public Licence  Version 2"
LICENSE="LGPL-2.1"

# Nothing listed in the docs for dependencies that I noticed
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

SLOT="1"
KEYWORDS="x86"

SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	# does not seems to consistently use DESTDIR where it needs to, but I could be wrong too
	# make DESTDIR=${D} install || die
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		oldincludedir=${D}/usr/include \
		install || die
}
