# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.1.6-r8.ebuild,v 1.1 2006/05/01 13:42:02 rl03 Exp $

inherit eutils flag-o-matic

DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz"
HOMEPAGE="http://www.htdig.org"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~amd64"
LICENSE="GPL-2"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"

SLOT="0"

IUSE="ssl"

export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

src_unpack() {
	unpack ${A}
	cd ${S}

	# security bug 80602
	epatch ${FILESDIR}/${P}-unescaped-output.diff

	use ssl && epatch ${FILESDIR}/${PV}-ssl.patch
}

src_compile() {
	append-flags -Wno-deprecated

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
	# einstall is required here
	einstall \
		SEARCH_DIR="${D}/var/www/localhost/htdocs/${PN}" \
		CGIBIN_DIR="${D}/var/www/localhost/cgi-bin" \
		IMAGE_DIR="${D}/var/www/localhost/htdocs/${PN}"

	dodoc ChangeLog COPYING README
	dohtml -r htdoc

	dosed /etc/${PN}/${PN}.conf
	dosed /usr/bin/rundig

	# symlink htsearch so it can be easily found. see bug #62087
	dosym /var/www/localhost/cgi-bin/htsearch /usr/bin/htsearch
}
