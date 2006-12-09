# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/mimedefang/mimedefang-2.57.ebuild,v 1.2 2006/12/09 11:29:21 ticho Exp $

inherit eutils

DESCRIPTION="A program for Milter supported mail servers that implements antispam, antivirus, and other customizable filtering on email messages"
HOMEPAGE="http://www.mimedefang.org/"
SRC_URI="http://www.mimedefang.org/static/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( mail-filter/libmilter >=mail-mta/sendmail-8.13 )
	>=dev-perl/MIME-tools-5.413
	virtual/perl-MIME-Base64
	dev-perl/Digest-SHA"

pkg_setup() {
	enewgroup defang
	enewuser defang -1 -1 -1 defang
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	fowners defang:defang /etc/mail/mimedefang-filter
	fperms 400 /etc/mail/mimedefang-filter
	insinto /etc/mail/
	insopts -m 644
	newins "${S}"/SpamAssassin/spamassassin.cf sa-mimedefang.cf

	keepdir /var/spool/{MD-Quarantine,MIMEDefang}
	fowners defang:defang /var/spool/{MD-Quarantine,MIMEDefang}
	fperms 700 /var/spool/{MD-Quarantine,MIMEDefang}

	dodir /var/log/mimedefang
	keepdir /var/log/mimedefang

	newinitd "${FILESDIR}"/${PN}.init ${PN}
	newconfd "${FILESDIR}"/${PN}.conf ${PN}

	dodir /usr/share/doc/${PF}/
	mv "${S}/examples" "${D}/usr/share/doc/${PF}/"
}

pkg_preinst() {
	enewgroup defang
	enewuser defang -1 -1 -1 defang
}
