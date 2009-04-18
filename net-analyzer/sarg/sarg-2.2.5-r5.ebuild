# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-2.2.5-r5.ebuild,v 1.3 2009/04/18 13:40:56 ranger Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Squid Analysis Report Generator"
HOMEPAGE="http://sarg.sourceforge.net/sarg.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		mirror://gentoo/${P}-patchset-5.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

DEPEND="media-libs/gd[png,truetype]"
RDEPEND="${DEPEND}"

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/patches/" EPATCH_SUFFIX="patch" epatch

	einfo "Running sed to substitute paths..."
	sed \
		-e 's:/usr/local/squid/var/logs/access.log:/var/log/squid/access.log:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
		-e 's:/var/www/html/squid-reports:/var/www/localhost/htdocs/squid-reports:' \
		-i sarg.conf || die

	sed \
		-e 's:"/usr/local/squid/var/logs/access.log":"/var/log/squid/access.log":' \
		-e 's:"/var/www/html/squid-reports":"/var/www/localhost/htdocs/squid-reports":' \
		-e 's:"/usr/local/sarg/passwd":"/etc/sarg/passwd":' \
			-i log.c || die #43132

	sed	-e 's:/usr/local/sarg/passwd:/etc/sarg/passwd:' \
		-i htaccess || die

	sed -e 's:/usr/local/squid/logs/access.log:/var/log/squid/access.log:' \
		-i splitlog.c convlog.c || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/squid/etc/passwd:/etc/squid/passwd:' \
		-i user_limit_block || die

	sed -e 's:/usr/local/squid/etc/block.txt:/etc/squid/etc/block.txt:' \
		-i sarg-php/sarg-block-it.php || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
		-e 's:/usr/local/squid/logs/access.log:/var/log/squid/access.log:' \
			-i sarg.1 sarg-php/sarg-squidguard-block.php || die

	sed -i -e 's:sarg_tmp:sarg:' email.c || die #64743
	eautoreconf
}

src_configure() {
	econf \
		--enable-bindir=/usr/bin \
		--enable-mandir=/usr/share/man/man1 \
		--enable-sysconfdir=/etc/sarg/
}

src_install() {
	# This is workaround for sarg installation script, which does not create dirs
	dodir /etc/sarg /usr/sbin

	make \
		BINDIR="${D}"/usr/sbin \
		MANDIR="${D}"/usr/share/man/man1 \
		SYSCONFDIR="${D}"/etc/sarg \
		HTMLDIR="${D}"/var/www/html \
		install || die "sarg installation failed"

	dodoc BETA-TESTERS CONTRIBUTORS DONATIONS README ChangeLog htaccess
}
