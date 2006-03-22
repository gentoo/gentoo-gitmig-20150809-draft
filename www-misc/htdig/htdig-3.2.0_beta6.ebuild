# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.2.0_beta6.ebuild,v 1.6 2006/03/22 19:45:58 eradicator Exp $

inherit webapp eutils flag-o-matic

MY_PV=${PV/_beta/b}
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~amd64"
LICENSE="GPL-2"

RDEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"
DEPEND="${RDEPEND}"

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	./configure \
		--prefix=/usr \
		--with-config-dir=/${MY_HOSTROOTDIR}/${PN} \
		--with-default-config-file=${MY_HOSTROOTDIR}/${PN}/${PN}.conf \
		--with-common-dir=/usr/share/${PN} \
		--with-database-dir=${MY_HOSTROOTDIR}/${PN}/db \
		--with-cgi-bin-dir=${MY_CGIBINDIR} \
		--with-image-dir=${MY_HTDOCSDIR} \
		--with-search-dir=${MY_HOSTROOTDIR} \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${PN}

	make DESTDIR=${D} install || die "make install failed"

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	dosed ${MY_HOSTROOTDIR}/${PN}/${PN}.conf
	dosed /usr/bin/rundig

	# symlink htsearch so it can be easily found. see bug #62087.
	dosym ${MY_CGIBINDIR}/htsearch /usr/bin/htsearch

	webapp_configfile ${MY_HOSTROOTDIR}/${PN}/${PN}.conf
	webapp_src_install
}
