# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_encoding/mod_encoding-20021209.ebuild,v 1.3 2004/04/04 22:45:28 zul Exp $

DESCRIPTION="Apache module for non-ascii filename interoperability"
HOMEPAGE="http://webdav.todo.gr.jp/"

S=${WORKDIR}/${P}
SRC_URI="http://webdav.todo.gr.jp/download/${P}.tar.gz"

DEPEND="=net-www/apache-1*"
KEYWORDS="~x86"
LICENSE="Apache-1.1"
SLOT="0"

src_compile() {
	cd ${S}/lib
	./configure --prefix=${WORKDIR}/iconv-hook || die
	make install || die

	cd ${S}
	econf --with-iconv-hook=${WORKDIR}/iconv-hook/include/iconv-hook || die
	emake LIBS="-L${WORKDIR}/iconv-hook/lib -liconv_hook" || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe ${PN}.so
	dolib.so ${WORKDIR}/iconv-hook/lib/libiconv_hook.so*

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/${PN}.conf

	dodoc AUTHORS COPYING ChangeLog INSTALL README*
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/${PN}.so ${PN}.c encoding_module \
		addconf=conf/addon-modules/${PN}.conf
	:;
}
