# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/isync/isync-1.0.4.ebuild,v 1.3 2011/06/07 11:12:01 eras Exp $

inherit eutils

DESCRIPTION="MailDir mailbox synchronizer"
HOMEPAGE="http://isync.sourceforge.net/"
SRC_URI="mirror://sourceforge/isync/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND=">=sys-libs/db-4.2
	ssl? ( >=dev-libs/openssl-0.9.6 )"
RDEPEND="${DEPEND}"

src_compile () {
	econf --with-prefix="${D}" \
		$(use_with ssl) \
		|| die 'Configure failed'

	emake || die "Error compiling"
}

src_install()
{
	einstall || die 'Error installing'
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF}
}
