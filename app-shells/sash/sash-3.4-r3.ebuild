# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.4-r3.ebuild,v 1.7 2002/07/16 03:07:04 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small UNIX Shell with readline suppport"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz
         http://dimavb.st.simbirsk.su/vlk/sash-3.x-readline.diff.gz"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"
if [ "`use static`" ] ; then
RDEPEND=""
fi

HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"

KEYWORDS="x86 ppc"

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  if [ "`use readline`" ]
  then
    gzip -dc ${DISTDIR}/sash-3.x-readline.diff.gz | patch -p1

    cp Makefile Makefile.orig
    sed -e "s:-O2:${CFLAGS}:" -e "s:-ltermcap:-lncurses:" Makefile.orig > Makefile
  else
    cp Makefile Makefile.orig
    sed -e "s:-O3:${CFLAGS}:" Makefile.orig > Makefile
  fi
}
src_compile() {

    if [ "`use static`" ]
    then
        try make
    else
	    try make LDFLAGS=""
    fi
}

src_install() {

	into /
	dobin sash
	into /usr
	doman sash.1
	dodoc README

}






