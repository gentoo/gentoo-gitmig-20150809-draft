# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/smtptools/smtptools-0.2.3.ebuild,v 1.5 2005/03/24 03:01:24 vapier Exp $

DESCRIPTION="A collection of tools to send or receive mails with SMTP"
HOMEPAGE="http://www.ohse.de/uwe/software/${PN}.html"
SRC_URI="ftp://ftp.ohse.de/uwe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""

src_compile() {
	# the configure check looks for the symbol name 'dn_expand' in 
	# libresolv but later glibc's use the internal symbol name 
	# '__dn_expand' and macro 'dn_expand' to '__dn_expand' in the 
	# resolv.h header file ... lets force the func to be detected.
	ac_cv_lib_resolv_dn_expand="yes" \
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "Installer failed"
	dodoc AUTHORS README README.cvs README.smtpblast \
		README.tomaildir README.usmtpd TODO
}
