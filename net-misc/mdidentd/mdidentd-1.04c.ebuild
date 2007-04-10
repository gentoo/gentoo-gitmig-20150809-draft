# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mdidentd/mdidentd-1.04c.ebuild,v 1.1 2007/04/10 13:40:40 armin76 Exp $

inherit eutils

DESCRIPTION="This is an identd with provides registering of idents"
HOMEPAGE="http://druglord.freelsd.org/ezbounce/"
SRC_URI="http://druglord.freelsd.org/ezbounce/files/ezbounce-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

S=${WORKDIR}/ezbounce-${PV}

pkg_setup() {
	enewgroup mdidentd
	enewuser mdidentd -1 -1 /dev/null mdidentd
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.04a-security.patch
	epatch "${FILESDIR}"/1.04a-pidfile.patch
}

src_compile() {
	econf $(use_with ssl) || die
	emake -C mdidentd CXX_OPTIMIZATIONS="${CXXFLAGS}" || die
}

src_install() {
	dosbin mdidentd/mdidentd || die
	dodoc mdidentd/README

	newinitd "${FILESDIR}"/mdidentd.init.d mdidentd
	newconfd "${FILESDIR}"/mdidentd.conf.d mdidentd
}
