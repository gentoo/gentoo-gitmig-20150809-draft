# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-0.5.0.ebuild,v 1.2 2007/07/13 00:25:32 beandog Exp $

inherit versionator

DESCRIPTION="assembler that supports amd64"
HOMEPAGE="http://www.tortall.net/projects/yasm/"
MYP="${PN}-$(delete_version_separator 3 ${PV})"
S="${WORKDIR}/${MYP}"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL
}
