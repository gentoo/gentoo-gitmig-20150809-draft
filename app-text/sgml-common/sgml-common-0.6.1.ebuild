# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.1.ebuild,v 1.5 2001/06/06 16:55:51 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Base ISO character entities and utilities for SGML"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${A}
	 http://download.sourceforge.net/pub/mirrors/kde/devel/docbook/SOURCES/${A}"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"

src_unpack() {

    unpack ${A}
    # We use a hacked version of install-catalog that supports the ROOT variable
    cp ${FILESDIR}/${P}-install-catalog.in ${S}/bin
}

src_compile() {
  try ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man
  try make
}
src_install () {
    try make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man \
        docdir=${D}/usr/share/doc install

}

pkg_postinst() {
  if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
    install-catalog --add /etc/sgml/sgml-ent.cat /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
    install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/sgml-ent.cat
  else
    echo "install-catalog not found!"
  fi
}

pkg_prerm() {
    if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
      [ -e "etc/sgml/sgml-docbook.cat" ] && install-catalog --remove /etc/sgml/sgml-docbook.cat /etc/sgml/sgml-ent.cat
      [ -e "etc/sgml/sgml-ent.cat" ] && install-catalog --remove /etc/sgml/sgml-ent.cat /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
    fi
}