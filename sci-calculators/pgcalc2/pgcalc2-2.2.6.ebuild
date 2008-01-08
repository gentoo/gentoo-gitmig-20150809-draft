# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/pgcalc2/pgcalc2-2.2.6.ebuild,v 1.2 2008/01/08 15:18:13 bicatali Exp $

inherit versionator kde

MY_PV=$(get_major_version).$(get_version_component_range 2)-$(get_version_component_range 3)
MY_P=${PN}-${MY_PV}

DESCRIPTION="Powerful scientific calculator for KDE"
SRC_URI="mirror://sourceforge/${PN/2/}/${MY_P}.tar.gz"
HOMEPAGE="http://www.pgcalc.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="doc"

need-kde 3

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS
	if use doc; then
		dohtml -r "${S}"/htmldoc/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	einfo "To use another skin, start ${PN} with:"
	einfo "\t ${MY_PN} --skinname=<skin>"
	einfo "<skin> is one of $(ls /usr/share/apps/pgcalc2/skins)"
}
