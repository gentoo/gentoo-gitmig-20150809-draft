# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/dosfstools/dosfstools-2.8.ebuild,v 1.2 2001/08/28 02:56:49 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="dos filesystem tools"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/${P}.src.tar.gz"
HOMEPAGE="ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:PREFIX\ \=:PREFIX\ \=\ \/usr:" -e "s:\/usr\/man:\/share\/man:" Makefile | cat > Makefile
}

src_compile() {
	make OPTFLAGS="${CFLAGS}" || die
}

src_install () {
	make PREFIX=${D}/usr install || die
	dodoc CHANGES TODO
	newdoc dosfsck/README README.dosfsck
	newdoc dosfsck/CHANGES CHANGES.dosfsck
	newdoc dosfsck/COPYING COPYING.dosfsck
	newdoc mkdosfs/README README.mkdosfs
	newdoc mkdosfs/ChangeLog ChangeLog.mkdosfs
}

