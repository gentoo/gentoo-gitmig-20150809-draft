# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-extprefs/gaim-extprefs-0.4-r1.ebuild,v 1.2 2005/06/16 13:43:17 rizzo Exp $

inherit eutils

DESCRIPTION="A plugin that takes advantage of existing gaim functionality to
provide preferences that are often desired but are not included in gaim."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/extendedprefs-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"

IUSE=""

RDEPEND=">=net-im/gaim-1.0.0"

DEPEND="${RDEPEND}
	>sys-devel/libtool-1.5.14"

S="${WORKDIR}/extendedprefs-${PV}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch  ${FILESDIR}/${P}-64bitfix.patch
}

src_compile() {
	#econf || die
	emake || die "emake failed"
}

src_install() {
	make PREFIX=${D}/usr install || die
}
