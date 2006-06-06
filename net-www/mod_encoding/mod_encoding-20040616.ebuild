# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_encoding/mod_encoding-20040616.ebuild,v 1.1 2006/06/06 11:05:47 hollow Exp $

inherit apache-module

DESCRIPTION="Apache module for non-ascii filename interoperability"
HOMEPAGE="http://webdav.todo.gr.jp/"
SRC_URI="http://webdav.todo.gr.jp/download/experimental/${PN}.c.apache2.${PV}"

IUSE=""
DEPEND=""
KEYWORDS="~x86"
LICENSE="as-is"
SLOT="0"

APACHE2_MOD_CONF="30_${PN}"
APACHE2_MOD_DEFINE="ENCODING"

need_apache2

src_unpack() {
	mkdir -p ${S} && cp ${DISTDIR}/${PN}.c.apache2.${PV} ${S}/${PN}.c || die
	cd ${S} || die

	sed -i -e "s:iconv_hook/iconv:iconv:" ${PN}.c || die
}
