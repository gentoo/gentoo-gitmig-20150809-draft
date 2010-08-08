# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subcheck/subcheck-0.78.2.ebuild,v 1.1 2010/08/08 00:48:39 sbriesen Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Subcheck checks srt subtitle files for errors"
HOMEPAGE="http://subcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e "s:${PN}.pl:${PN}:g" all-checksub
}

src_compile() {
	:  # nothing to do
}

src_install() {
	doman man/subcheck.8.gz
	newbin subcheck.pl subcheck
	dobin all-checksub
	dodoc Changes
}
