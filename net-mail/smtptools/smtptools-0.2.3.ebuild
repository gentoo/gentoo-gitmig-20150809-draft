# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/smtptools/smtptools-0.2.3.ebuild,v 1.1 2004/10/31 14:12:01 ticho Exp $

DESCRIPTION="A collection of tools to send or receive mails with SMTP"
SRC_URI="ftp://ftp.ohse.de/uwe/releases/${P}.tar.gz"
HOMEPAGE="http://www.ohse.de/uwe/software/${PN}.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installer failed"
	dodoc AUTHORS COPYING README README.cvs README.smtpblast \
	      README.tomaildir README.usmtpd TODO
}
