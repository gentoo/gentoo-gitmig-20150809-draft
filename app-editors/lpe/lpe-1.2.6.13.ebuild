# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lpe/lpe-1.2.6.13.ebuild,v 1.9 2009/02/15 06:34:45 dragonheart Exp $

inherit multilib

DESCRIPTION="a lightweight programmers editor"
HOMEPAGE="http://packages.qa.debian.org/l/lpe.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

RDEPEND=">=sys-libs/slang-2.1.3"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

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
}
