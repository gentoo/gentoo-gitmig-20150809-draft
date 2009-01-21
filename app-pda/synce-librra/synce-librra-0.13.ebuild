# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librra/synce-librra-0.13.ebuild,v 1.3 2009/01/21 11:45:54 mescalinum Exp $

inherit versionator

DESCRIPTION="SynCE - RRA protocol library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lang/python
		dev-python/pyrex
		dev-libs/libmimedir
		!app-pda/synce-rra
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*"
RDEPEND="${RDEPEND}"

MY_P="librra-${PV}"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
}
