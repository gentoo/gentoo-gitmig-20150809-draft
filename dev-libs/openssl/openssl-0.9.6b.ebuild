# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.6b.ebuild,v 1.6 2001/08/31 03:23:38 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/${A}"
HOMEPAGE="http://www.opensl.org/"

DEPEND="virtual/glibc >=sys-devel/perl-5"


RDEPEND="virtual/glibc "
src_unpack() {

  unpack ${A}
  cd ${S}
  try patch -p0 < ${FILESDIR}/${P}-Makefile.org-gentoo.diff
  cp Configure Configure.orig
  sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" \
    Configure.orig > Configure
# Makefile borkage. The MANDIR is set to ${OPENSSLDIR}/man which is lame
	sed -e 's:MANDIR=$(OPENSSLDIR)/man:MANDIR=/usr/share/man:g' Makefile | cat > Makefile
}

src_compile() {

   ./config --prefix=/usr --openssldir=/usr/ssl shared threads
   try make all
}

src_install() {
    dodir /usr/ssl
    try make INSTALL_PREFIX=${D} install

    dodoc CHANGES* FAQ LICENSE NEWS README
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.gif doc/*.html
    insinto /usr/share/emacs/site-lisp
    doins doc/c-indentation.el
}



