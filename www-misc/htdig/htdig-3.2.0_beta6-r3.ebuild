# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/htdig/htdig-3.2.0_beta6-r3.ebuild,v 1.8 2009/12/13 21:57:34 abcd Exp $

inherit eutils autotools

MY_PV=${PV/_beta/b}
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="HTTP/HTML indexing and searching system"
HOMEPAGE="http://www.htdig.org"
SRC_URI="http://www.htdig.org/files/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="ssl"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-quoting.patch
	eautoreconf
}

src_compile() {
	econf \
		--with-config-dir=/etc/${PN} \
		--with-default-config-file=/etc/${PN}/${PN}.conf \
		--with-database-dir=/var/lib/${PN}/db \
		--with-cgi-bin-dir=/var/www/localhost/cgi-bin \
		--with-search-dir=/var/www/localhost/htdocs/${PN} \
		--with-image-dir=/var/www/localhost/htdocs/${PN} \
		$(use_with ssl)

#		--with-image-url-prefix=file:///var/www/localhost/htdocs/${PN} \

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc ChangeLog README
	dohtml -r htdoc

	sed -i "s:${D}::g" \
		"${D}"/etc/${PN}/${PN}.conf \
		"${D}"/usr/bin/rundig \
		|| die "sed failed (removing \${D} from installed files)"

	# symlink htsearch so it can be easily found. see bug #62087
	dosym ../../var/www/localhost/cgi-bin/htsearch /usr/bin/htsearch
}
