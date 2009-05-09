# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/milter-regex/milter-regex-1.7.ebuild,v 1.4 2009/05/09 12:32:01 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A milter-based regular expression filter"
HOMEPAGE="http://www.benzedrine.cx/milter-regex.html"
SRC_URI="http://www.benzedrine.cx/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( sys-devel/bison dev-util/yacc )
	|| ( mail-filter/libmilter mail-mta/sendmail )"
RDEPEND="" # libmilter is a static library

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-rules.patch # fix a typo in upstream sample rules
	epatch "${FILESDIR}"/${P}-yacc.patch
}

src_compile() {
	emake -f Makefile.linux milter-regex || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe milter-regex

	keepdir /var/run/milter-regex

	insinto /etc/mail
	newins rules milter-regex.conf

	newconfd "${FILESDIR}"/milter-regex-conf milter-regex
	newinitd "${FILESDIR}"/milter-regex-init milter-regex

	doman *.8
}

pkg_preinst() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter

	fowners milter:milter /var/run/milter-regex
}

pkg_postinst() {
	elog "If you're using Sendmail, you'll need to add this to your sendmail.mc:"
	elog "  INPUT_MAIL_FILTER(\`milter-regex', \`S=unix:/var/run/milter-regex/milter-regex.sock, T=S:30s;R:2m')"
	elog
	elog "If you are using Postfix, you'll need to add this to your main.cf:"
	elog "  smtpd_milters     = unix:/var/run/milter-regex/milter-regex.sock"
	elog "  non_smtpd_milters = unix:/var/run/milter-regex/milter-regex.sock"
}
