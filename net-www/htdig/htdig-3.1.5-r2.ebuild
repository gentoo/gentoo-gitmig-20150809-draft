# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/htdig/htdig-3.1.5-r2.ebuild,v 1.1 2002/03/07 20:00:49 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz
	 http://www.geocities.com/alexismikhailov/htdig_3_1_x.diff.zip
	 http://www.geocities.com/alexismikhailov/htdig_3_1_x_noindex.diff.zip"
HOMEPAGE="http://www.htdig.org"

DEPEND="virtual/glibc
        >=sys-devel/gcc-2.95.2
	>=sys-libs/zlib-1.1.3
	app-arch/unzip"

src_unpack() {

  unpack ${P}.tar.gz

  cp ${FILESDIR}/CONFIG.in ${S}

  cd ${S}
  for x in htdig_3_1_{x,x_noindex}.diff.zip; do
    cp ${DISTDIR}/${x} .
    unzip ${x}  
    patch -p1 < ${x//.zip}
  done

}

src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST} \
	--with-cgi-bin-dir=/usr/bin \
	--with-image-dir=/usr/local/httpd/images/htdig \
	--with-search-dir=/usr/local/httpd/htdocs/htdig || die "died configuring"
    emake || die "died making"

}

src_install () {

    cd ${S}
    make DESTDIR=${D} CGIBIN_DIR=${D}/usr/bin \
	SEARCH_DIR=${D}/usr/local/httpd/htdocs/htdig \
	IMAGE_DIR=${D}/usr/local/httpd/htdocs/images/htdig \
	exec_prefix=${D}/usr install || die "died making install"
    dosed /etc/httpd/htdig.conf /usr/bin/rundig
    dodoc ChangeLog COPYING README

}


