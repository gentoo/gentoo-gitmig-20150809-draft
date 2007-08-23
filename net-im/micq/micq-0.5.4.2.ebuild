# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.5.4.2.ebuild,v 1.2 2007/08/23 19:23:02 jokey Exp $

DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.micq.org/"
SRC_URI="http://www.micq.org/source/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="tcl ssl"

DEPEND="ssl? ( >=net-libs/gnutls-0.8.10 dev-libs/openssl )
	tcl? ( dev-lang/tcl )"

src_compile() {
	econf \
		$(use_enable tcl) \
		$(use_enable ssl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
