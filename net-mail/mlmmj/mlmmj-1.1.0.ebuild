# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mlmmj/mlmmj-1.1.0.ebuild,v 1.1 2004/12/04 12:49:16 klieber Exp $

inherit eutils

MY_PV="${PV/_rc/-RC}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Mailing list managing made joyful"
HOMEPAGE="http://mlmmj.mmj.dk/"
SRC_URI="http://mlmmj.mmj.dk/files/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos"
IUSE=""
DEPEND="virtual/mta"
#RDEPEND=""
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
