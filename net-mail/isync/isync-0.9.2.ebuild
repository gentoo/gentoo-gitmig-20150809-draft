# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/isync/isync-0.9.2.ebuild,v 1.1 2004/09/06 12:24:59 ticho Exp $

inherit eutils

DESCRIPTION="MailDir mailbox synchronizer"
HOMEPAGE="http://isync.sourceforge.net/"
SRC_URI="mirror://sourceforge/isync/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="
	virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile () {
	econf --with-prefix=${D} \
	$(use_with ssl) \
	|| die 'Configure failed'
	emake || die "Error compiling"
}

src_install()
{
	einstall || die 'Error installing'
	dodoc README COPYING AUTHORS ChangeLog NEWS TODO isyncrc.sample
}
