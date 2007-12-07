# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/pypolicyd-spf/pypolicyd-spf-0.5.2.ebuild,v 1.2 2007/12/07 07:28:57 opfer Exp $

inherit distutils eutils

DESCRIPTION="Python based policy daemon for Postfix SPF checking"
SRC_URI="http://www.openspf.org/blobs/${P}.tar.gz"
HOMEPAGE="http://www.openspf.org/Software"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/pyspf-2.0.3"

src_unpack() {
	unpack "${A}"
	sed -i -e "s/'local',//g" "${S}"/setup.py || die
}
