# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-2.3.1-r2.ebuild,v 1.3 2011/11/03 10:18:54 chainsaw Exp $

EAPI="4"
inherit eutils

DESCRIPTION="Squid Analysis Report Generator"
HOMEPAGE="http://sarg.sourceforge.net/sarg.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="0"
IUSE=""

DEPEND="media-libs/gd[png,truetype]"
RDEPEND="${DEPEND}"

src_prepare() {
	einfo "Running sed to substitute paths..."
	sed \
		-e 's:/usr/local/squid/var/logs/access.log:/var/log/squid/access.log:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
		-e 's:/var/www/html/squid-reports:/var/www/localhost/htdocs/squid-reports:' \
		-e 's:/usr/local/sarg/exclude_codes:/etc/sarg/exclude_codes:' \
		-i sarg.conf || die

	sed -e 's:"/var/www/html/squid-reports":"/var/www/localhost/htdocs/squid-reports":' \
			-i log.c || die #43132

	sed	-e 's:/usr/local/sarg/passwd:/etc/sarg/passwd:' \
		-i htaccess || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/squid/etc/passwd:/etc/squid/passwd:' \
		-i user_limit_block || die

	sed -e 's:/usr/local/squid/etc/block.txt:/etc/squid/etc/block.txt:' \
		-i sarg-php/sarg-block-it.php || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
			-i sarg.1 sarg-php/sarg-squidguard-block.php || die

	epatch "${FILESDIR}/${P}-underlinking.patch"

	# https://sourceforge.net/tracker/?func=detail&aid=3415225&group_id=68910&atid=522793
	sed 's:\(@mandir@\):\1/man1:' -i Makefile.in || die #379395
}

src_configure() {
	econf --sysconfdir=/etc/sarg/
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc BETA-TESTERS CONTRIBUTORS DONATIONS README ChangeLog htaccess
}
