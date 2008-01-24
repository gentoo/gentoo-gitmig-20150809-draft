# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lpe/lpe-1.2.6.13.ebuild,v 1.1 2008/01/24 11:49:19 drac Exp $

inherit autotools eutils multilib

DESCRIPTION="a lightweight programmers editor"
HOMEPAGE="http://packages.qa.debian.org/l/lpe.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND=">=sys-libs/slang-2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-slang-2.patch
	eautoconf
}

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake libdir="${D}/usr/$(get_libdir)" \
		prefix="${D}/usr" \
		datadir="${D}/usr/share" \
		mandir="${D}/usr/share/man" \
		infodir="${D}/usr/share/info" \
		docdir="${D}/usr/share/doc/${PF}" \
		exdir="${D}/usr/share/doc/${PF}/examples" \
		install || die "emake install failed."
	dodoc AUTHORS BUGS Changelog CUSTOMIZE IDEAS MODES NEWS README TODO
	prepalldocs
}
