# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-2.0.0.ebuild,v 1.3 2004/09/01 10:13:25 aliz Exp $

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="nls"

DEPEND="~net-libs/libfwbuilder-2.0.0
	nls? ( >=sys-devel/gettext-0.11.4 )"

src_compile() {
	econf `use_enable nls` || die "./configure failed"

	addwrite "${QTDIR}/etc/settings"
	emake || die "emake failed"
}

src_install() {
	emake DDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	echo ""
	einfo "You need to emerge iproute2 on the machine that"
	einfo "will run the firewall script."
	echo ""
}
