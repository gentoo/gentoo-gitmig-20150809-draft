# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-0.92-r1.ebuild,v 1.2 2004/11/01 21:17:12 ticho Exp $

DESCRIPTION="The No-Brainer SMTP"
SRC_URI="http://www.gentoo-es.org/~ferdy/${P}.tar.bz2"
HOMEPAGE="http://nbsmtp.ferdyx.org"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa"
LICENSE="GPL-2"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf `use_enable ssl` || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	dobin nbsmtp
	dodoc INSTALL DOCS COPYING
}
