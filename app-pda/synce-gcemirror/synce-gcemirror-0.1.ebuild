# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gcemirror/synce-gcemirror-0.1.ebuild,v 1.1 2009/08/07 00:34:58 mescalinum Exp $

MY_PN="${PN/synce-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GTK+ remote viewer display for SynCE devices."
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-pda/synce-libsynce"
RDEPEND="app-pda/synce"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
