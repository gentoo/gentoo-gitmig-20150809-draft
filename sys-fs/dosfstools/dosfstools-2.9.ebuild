# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dosfstools/dosfstools-2.9.ebuild,v 1.3 2004/02/15 17:31:05 absinthe Exp $

inherit eutils

DESCRIPTION="dos filesystem tools"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/${P}.src.tar.gz"
HOMEPAGE="ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/errno.patch
	sed -i "s:PREFIX\ \=:PREFIX\ \=\ \/usr:" Makefile
	sed	-i "s:\/usr\/man:\/share\/man:" Makefile

	# Bug: 34785 hardened-gcc transparently adds -fPIC so we must filter 
	# that away because this package cant cope. (Nov 30 2003 -solar)
	has_version 'sys-devel/hardened-gcc' && \
		sed -i -e "s:^DEBUGFLAGS.*:DEBUGFLAGS=-yet_exec:g" Makefile
}

src_compile() {
	# this package does *not* play well with optimisations
	# please dont change to: make OPTFLAGS="${CFLAGS}"
	make || die
}

src_install() {
	make PREFIX=${D}/usr install || die
	dodoc CHANGES TODO
	newdoc dosfsck/README README.dosfsck
	newdoc dosfsck/CHANGES CHANGES.dosfsck
	newdoc dosfsck/COPYING COPYING.dosfsck
	newdoc mkdosfs/README README.mkdosfs
	newdoc mkdosfs/ChangeLog ChangeLog.mkdosfs
}
