# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-2.2.2.ebuild,v 1.2 2006/10/17 03:02:50 tsunam Exp $

inherit eutils

DESCRIPTION="Squid Analysis Report Generator"
HOMEPAGE="http://sarg.sourceforge.net/sarg.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
IUSE=""

DEPEND="media-libs/gd"

pkg_setup() {
	built_with_use -a media-libs/gd png || die \
	"Please recompile media-libs/gd with USE=\"png\""
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fixes bug #43132
	sed -i \
	-e 's:"/usr/local/squid/var/logs/access.log":"/var/log/squid/access.log":' \
	-e 's:"/var/www/html/squid-reports":"/var/www/localhost/htdocs/squid-reports":' \
	log.c || die "setting default for gentoo directories... failed"

	sed -i \
	-e 's:/usr/local/squid/var/logs/access.log:/var/log/squid/access.log:' \
	-e 's:/var/www/html/squid-reports:/var/www/localhost/htdocs/squid-reports:' \
	sarg.conf || die "setting default for gentoo directories... failed"

	# Fixes bug #64743
	sed -i -e 's:sarg_tmp:sarg:' email.c || die "fixing dir in email.c failed"

	sed -i \
	-e 's:/usr/local/sarg/sarg.conf:/etc/sarg/sarg.conf:' \
	-e 's:/usr/local/squid/logs/access.log:/var/log/squid/access.log:' \
	sarg.1 || die "Failed to fix man page."
}

src_compile() {
	econf \
		--enable-bindir=/usr/bin \
		--enable-mandir=/usr/share/man/man1 \
		--enable-sysconfdir=/etc/sarg/ || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# This is workaround for sarg installation script, which does not create dirs
	dodir /etc/sarg /usr/sbin

	make \
		BINDIR=${D}/usr/sbin \
		MANDIR=${D}/usr/share/man/man1 \
		SYSCONFDIR=${D}/etc/sarg \
		HTMLDIR=${D}/var/www/html \
		install || die "sarg installation failed"

	dodoc BETA-TESTERS CONTRIBUTORS DONATIONS README ChangeLog htaccess
}
