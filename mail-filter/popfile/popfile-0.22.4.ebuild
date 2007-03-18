# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/popfile/popfile-0.22.4.ebuild,v 1.3 2007/03/18 04:42:26 genone Exp $

IUSE="cjk ipv6 mysql ssl xmlrpc"

S=${WORKDIR}
DESCRIPTION="Anti-spam bayesian filter"
HOMEPAGE="http://popfile.sourceforge.net/"
SRC_URI="mirror://sourceforge/popfile/${P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/perl-5.7.3
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	dev-perl/DBD-SQLite2
	dev-perl/HTML-Tagset
	dev-perl/HTML-Template
	dev-perl/TimeDate
	app-arch/unzip
	"

RDEPEND="${DEPEND}
	cjk? (
		dev-perl/Encode-compat
		dev-perl/Text-Kakasi
	)
	mysql? (
		dev-perl/DBD-mysql
	)
	ipv6? (
		dev-perl/IO-Socket-INET6
	)
	ssl? (
	    dev-libs/openssl
		!=dev-perl/IO-Socket-SSL-0.97
	    dev-perl/Net-SSLeay
	)
	xmlrpc? (
		dev-perl/PlRPC
	)
	"

src_compile() {
	# do nothing
	echo > /dev/null
}

src_install() {
	dodir /usr/share/popfile

	dodoc v*.change
	tar -cf - manual | ( cd ${D}/usr/share/doc/${P} && tar -xf - )

	find . -type f -print | xargs chmod 600
	find . -type d -print | xargs chmod 700
	tar -cf - * | ( cd ${D}/usr/share/popfile && tar -xf - )

	fperms 0755 /usr/share/popfile/{popfile,bayes,insert,pipe}.pl

	dosbin ${FILESDIR}/popfile
	fperms 0755 /usr/sbin/popfile
}

pkg_postinst () {
	elog "To start popfile, run /usr/sbin/popfile"
}
