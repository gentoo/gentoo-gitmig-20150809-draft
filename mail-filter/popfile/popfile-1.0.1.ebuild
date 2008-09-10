# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/popfile/popfile-1.0.1.ebuild,v 1.2 2008/09/10 15:45:08 darkside Exp $

DESCRIPTION="Anti-spam bayesian filter"
HOMEPAGE="http://getpopfile.org"
SRC_URI="http://getpopfile.org/downloads/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cjk ipv6 mysql ssl xmlrpc sqlite"

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	dev-perl/DBD-SQLite2
	dev-perl/HTML-Tagset
	dev-perl/HTML-Template
	dev-perl/TimeDate
	dev-perl/DBI
	perl-core/digest-base
	perl-core/Digest-MD5
	cjk? ( dev-perl/Encode-compat
		dev-perl/Text-Kakasi )
	mysql? ( dev-perl/DBD-mysql	)
	ipv6? (	dev-perl/IO-Socket-INET6 )
	ssl? ( dev-libs/openssl
		!=dev-perl/IO-Socket-SSL-0.97
	    dev-perl/Net-SSLeay	)
	xmlrpc? ( dev-perl/PlRPC )"
DEPEND="app-arch/unzip"

src_install() {
	dodoc *.change
	dohtml -r manual/*
	rm -rf manual *.change license
	insinto /usr/share/${PN}
	doins -r *
	fperms 755 /usr/share/${PN}/{popfile,insert,pipe,bayes}.pl
	dosbin "${FILESDIR}"/${PN}
}
