# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/cvsweb/cvsweb-1.93.ebuild,v 1.2 2000/11/01 04:44:23 achim Exp $

P=cvsweb-1.92
A=${P}.tar.gz
S=${WORKDIR}/cvsweb
DESCRIPTION="WWW interface to a CVS tree"
SRC_URI="http://stud.fh-heilbronn.de/~zeller/download/${A}"
HOMEPAGE="http://stud.fh-heilbronn.de/~zeller/cgi/cvsweg.cgi"

DEPEND=">=sys-devel/perl-5"

src_compile () {
  cp cvsweb.cgi cvsweb.cgi.orig
  sed -e "s:/usr/local/web/apache/conf/:/etc/httpd/:" cvsweb.cgi.orig >  cvsweb.cgi
}
src_install () {

    cd ${S}
    insinto /etc/httpd
    doins cvsweb.conf
    insinto /usr/local/httpd/cgi-bin
    insopts -m755
    doins cvsweb.cgi
    dodoc README TODO
}


