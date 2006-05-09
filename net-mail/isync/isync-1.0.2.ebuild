# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/isync/isync-1.0.2.ebuild,v 1.2 2006/05/09 16:35:22 squinky86 Exp $

inherit eutils

DESCRIPTION="MailDir mailbox synchronizer"
HOMEPAGE="http://isync.sourceforge.net/"
SRC_URI="mirror://sourceforge/isync/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND="virtual/libc
	>=sys-libs/db-4.2
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
	dodoc README COPYING AUTHORS ChangeLog NEWS TODO
}
