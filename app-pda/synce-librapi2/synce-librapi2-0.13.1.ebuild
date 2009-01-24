# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librapi2/synce-librapi2-0.13.1.ebuild,v 1.2 2009/01/24 12:34:55 mescalinum Exp $

inherit eutils versionator

DESCRIPTION="SynCE - RAPI communication library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-lang/python
		>=dev-python/pyrex-0.9.6
		>=dev-libs/check-0.8.2
		=app-pda/synce-libsynce-${synce_PV}*"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/librapi2-${PV}.tar.gz"
S="${WORKDIR}/librapi2-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUGS README README.contributing README.design TODO ChangeLog
}
