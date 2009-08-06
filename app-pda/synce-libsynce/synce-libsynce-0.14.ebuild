# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/synce-libsynce-0.14.ebuild,v 1.1 2009/08/06 12:24:25 mescalinum Exp $

inherit versionator

DESCRIPTION="SynCE - common library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hal"
DEPEND=">=dev-libs/check-0.8.3.1"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/libsynce-${PV}.tar.gz"
S="${WORKDIR}/libsynce-${PV}"

src_compile() {
	econf $(use_enable hal hal-support) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO ChangeLog
}
