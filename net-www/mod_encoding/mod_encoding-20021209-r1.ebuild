# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_encoding/mod_encoding-20021209-r1.ebuild,v 1.2 2005/02/25 18:12:57 hollow Exp $

inherit apache-module

DESCRIPTION="Apache module for non-ascii filename interoperability"
HOMEPAGE="http://webdav.todo.gr.jp/"
SRC_URI="http://webdav.todo.gr.jp/download/${P}.tar.gz"

IUSE=""
DEPEND=""
KEYWORDS="~x86"
LICENSE="Apache-1.1"
SLOT="0"

APACHE1_MOD_CONF="30_${PN}"
APACHE1_MOD_DEFINE="ENCODING"

DOCFILES="AUTHORS COPYING ChangeLog INSTALL README*"

need_apache1

src_compile() {
	cd ${S}/lib
	./configure --prefix=${WORKDIR}/iconv-hook || die
	make install || die

	cd ${S}
	econf --with-iconv-hook=${WORKDIR}/iconv-hook/include/iconv-hook || die
	emake LIBS="-L${WORKDIR}/iconv-hook/lib -liconv_hook" || die
}

src_install() {
	apache-module_src_install
	dolib.so ${WORKDIR}/iconv-hook/lib/libiconv_hook.so*
}
