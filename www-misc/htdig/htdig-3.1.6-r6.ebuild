# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.1.6-r6.ebuild,v 1.1 2004/08/29 16:46:29 rl03 Exp $

inherit webapp

DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~amd64"
LICENSE="GPL-2"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"

export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

src_compile() {
	cd ${S}
	./configure \
		--prefix=/usr \
		--with-config-dir=/${MY_HOSTROOTDIR}/${PN} \
		--with-cgi-bin-dir=${MY_CGIBINDIR} \
		--with-common-dir=/usr/share/${PN} \
		--with-database-dir=${MY_HOSTROOTDIR}/${PN}/db \
		--with-image-dir=${MY_HTDOCSDIR} \
		--with-default-config-file=${MY_HOSTROOTDIR}/${PN}/${PN}.conf \
		|| die

	emake || die
}

src_install () {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${PN}

	make 	\
		DESTDIR=${D} \
		CONFIG_DIR=${D}/${MY_HOSTROOTDIR}/${PN} \
		SEARCH_DIR=${D}/${MY_HOSTROOTDIR} \
		CGIBIN_DIR=${D}/${MY_CGIBINDIR} \
		COMMON_DIR=${D}/usr/share/${PN} \
		DATABASE_DIR=${D}/${MY_HOSTROOTDIR}/${PN}/db \
		IMAGE_DIR=${D}/${MY_HTDOCSDIR} \
		DEFAULT_CONFIG_FILE=${D}/${MY_HOSTROOTDIR}/${PN}/${PN}.conf \
		exec_prefix=${D}/usr \
		install || die

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	sed -e "s/@DATABASE_DIR@/\/var\/${PN}\/db/" -i ${D}/${MY_HOSTROOTDIR}/${PN}/htdig.conf

	dosed ${MY_HOSTROOTDIR}/${PN}/${PN}.conf
	dosed /usr/bin/rundig

	# symlink htsearch so it can be easily found. see bug #62087.
	dosym ${MY_CGIBINDIR}/htsearch /usr/bin/htsearch

	webapp_src_install
}
