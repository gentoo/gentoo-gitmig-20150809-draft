# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.4-r2.ebuild,v 1.3 2000/09/15 20:08:46 drobbins Exp $

P=sash-3.4    
A="${P}.tar.gz sash-3.x-readline.diff.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A small UNIX Shell with readline suppport"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz
         http://dimavb.st.simbirsk.su/vlk/sash-3.x-readline.diff.gz"

HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  gzip -dc ${DISTDIR}/sash-3.x-readline.diff.gz | patch -p1
  cp Makefile Makefile.orig
  sed -e "s:-O3:${CFLAGS}:" \
      -e "s:-ltermcap:-lncurses:" Makefile.orig > Makefile
}
src_compile() {                           
	cd ${S}

	try make
}

src_install() {                               
	cd ${S}
	into /
	dobin sash
	into /usr
	doman sash.1
	dodoc README

}






