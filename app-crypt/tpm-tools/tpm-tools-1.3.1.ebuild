# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-tools/tpm-tools-1.3.1.ebuild,v 1.4 2009/05/10 23:11:27 robbat2 Exp $

inherit autotools

DESCRIPTION="TrouSerS' support tools for the Trusted Platform Modules"
HOMEPAGE="http://trousers.sf.net"
SRC_URI="mirror://sourceforge/trousers/${P}.tar.gz"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

COMMON_DEPEND=">=app-crypt/trousers-0.3.0"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"
# TODO: add optionnal opencryptoki support
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e "s/-Werror //" -i configure.in
	eautoreconf
}

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
