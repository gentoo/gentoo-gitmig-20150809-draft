# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/climm/climm-0.6.ebuild,v 1.1 2007/09/17 10:48:41 jokey Exp $

DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.climm.org/"
SRC_URI="http://www.climm.org/source/${P}.tgz"

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
