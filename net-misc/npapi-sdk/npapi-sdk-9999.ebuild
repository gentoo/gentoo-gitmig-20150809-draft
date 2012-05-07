# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/npapi-sdk/npapi-sdk-9999.ebuild,v 1.6 2012/05/07 17:07:10 axs Exp $

EAPI=4
inherit autotools-utils

#if LIVE
EGIT_REPO_URI="git://github.com/mgorny/${PN}.git
	http://github.com/mgorny/${PN}.git"
inherit autotools git-2
#endif

DESCRIPTION="NPAPI headers bundle"
HOMEPAGE="https://github.com/mgorny/npapi-sdk/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
#if LIVE

KEYWORDS=""
SRC_URI=

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}
#endif
