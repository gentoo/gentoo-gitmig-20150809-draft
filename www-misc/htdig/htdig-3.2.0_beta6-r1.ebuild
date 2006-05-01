# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.2.0_beta6-r1.ebuild,v 1.1 2006/05/01 13:42:02 rl03 Exp $

inherit eutils flag-o-matic

MY_PV=${PV/_beta/b}
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~amd64"
LICENSE="GPL-2"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"

SLOT="0"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	econf \
		--with-config-dir=/etc/${PN} \
		--with-default-config-file=/etc/${PN}/${PN}.conf \
		--with-database-dir=/var/lib/${PN}/db \
		--with-cgi-bin-dir=/var/www/localhost/cgi-bin \
		--with-search-dir=/var/www/localhost/htdocs/${PN} \
		--with-image-dir=/var/www/localhost/htdocs/${PN} \
		--with-image-url-prefix=file:///var/www/localhost/htdocs/${PN} \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	dosed /etc/${PN}/${PN}.conf
	dosed /usr/bin/rundig

	# symlink htsearch so it can be easily found. see bug #62087
	dosym /var/www/localhost/cgi-bin/htsearch /usr/bin/htsearch
}
