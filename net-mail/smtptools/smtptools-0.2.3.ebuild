# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/smtptools/smtptools-0.2.3.ebuild,v 1.3 2005/03/03 14:36:18 vapier Exp $

DESCRIPTION="A collection of tools to send or receive mails with SMTP"
HOMEPAGE="http://www.ohse.de/uwe/software/${PN}.html"
SRC_URI="ftp://ftp.ohse.de/uwe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "Installer failed"
	dodoc AUTHORS README README.cvs README.smtpblast \
		README.tomaildir README.usmtpd TODO
}
