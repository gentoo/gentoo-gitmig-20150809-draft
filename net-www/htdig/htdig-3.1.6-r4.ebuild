# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/htdig/htdig-3.1.6-r4.ebuild,v 1.11 2003/09/06 01:54:08 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="x86 sparc ppc mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"

export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

src_compile() {

	cd ${S}
	./configure \
		--prefix=/usr \
		--with-config-dir=/etc/${PN} \
		--with-cgi-bin-dir=/home/httpd/cgi-bin \
		--with-common-dir=/usr/share/${PN} \
		--with-database-dir=/var/${PN}/db \
		--with-image-dir=/home/httpd/htdocs/${PN} \
		--with-default-config-file=/etc/${PN}/${PN}.conf \
		|| die

	emake || die

}

src_install () {

	make 	\
		DESTDIR=${D} \
		CONFIG_DIR=${D}/etc/${PN} \
		SEARCH_DIR=${D}/home/httpd/htdocs/${PN} \
		CGIBIN_DIR=${D}/home/httpd/cgi-bin \
		COMMON_DIR=${D}/usr/share/${PN} \
		DATABASE_DIR=${D}/var/${PN}/db \
		IMAGE_DIR=${D}/home/httpd/htdocs/${PN} \
		DEFAULT_CONFIG_FILE=${D}/etc/${PN}/${PN}.conf \
		exec_prefix=${D}/usr \
		install || die

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	insinto /etc/conf.d
	doins installdir/htdig.conf

	dosed /etc/htdig/htdig.conf
	dosed /usr/bin/rundig

	touch ${D}/var/htdig/db/word2root.db
	touch ${D}/var/htdig/db/root2word.db

}

