# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.1.6-r7.ebuild,v 1.1 2005/02/10 16:36:03 ka0ttic Exp $

inherit webapp eutils flag-o-matic

DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="x86 ~sparc ~ppc ~mips ~amd64"
LICENSE="GPL-2"

RDEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"
DEPEND="${RDEPEND}"

export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

src_unpack() {
	unpack ${A}
	cd ${S}

	# security bug 80602
	epatch ${FILESDIR}/${P}-unescaped-output.diff

}

src_compile() {
	append-flags -Wno-deprecated

	./configure \
		--prefix=/usr \
		--with-config-dir=/${MY_HOSTROOTDIR}/${PN} \
		--with-cgi-bin-dir=${MY_CGIBINDIR} \
		--with-common-dir=/usr/share/${PN} \
		--with-database-dir=${MY_HOSTROOTDIR}/${PN}/db \
		--with-image-dir=${MY_HTDOCSDIR} \
		--with-default-config-file=${MY_HOSTROOTDIR}/${PN}/${PN}.conf \
		|| die "configure failed"

	emake || die "emake failed"
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
		install || die "make install failed"

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	sed -e "s/@DATABASE_DIR@/\/var\/${PN}\/db/" -i ${D}/${MY_HOSTROOTDIR}/${PN}/htdig.conf

	dosed ${MY_HOSTROOTDIR}/${PN}/${PN}.conf
	dosed /usr/bin/rundig

	# symlink htsearch so it can be easily found. see bug #62087.
	dosym ${MY_CGIBINDIR}/htsearch /usr/bin/htsearch

	webapp_src_install
}
