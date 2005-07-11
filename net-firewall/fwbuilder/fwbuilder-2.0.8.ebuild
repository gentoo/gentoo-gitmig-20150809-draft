# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-2.0.8.ebuild,v 1.1 2005/07/11 10:57:31 carlo Exp $

inherit eutils

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~ppc64"
IUSE="nls"

DEPEND="~net-libs/libfwbuilder-${PV}
	nls? ( >=sys-devel/gettext-0.11.4 )
	>=dev-libs/libxslt-1.0.7"

src_compile() {
	export QMAKESPEC="linux-g++"
	export QMAKE="${QTDIR}/bin/qmake"

	econf `use_enable nls` || die

	addwrite "${QTDIR}/etc/settings"
	emake || die "emake failed"
}

src_install() {
	emake DDIR=${D} install || die
	insinto /usr/share/pixmaps
	doins src/gui/icons/firewall_64.png
	make_desktop_entry fwbuilder "Firewall Builder" "/usr/share/pixmaps/firewall_64.png" "System;Qt"
}

pkg_postinst() {
	echo
	einfo "You need to emerge iproute2 on the machine that"
	einfo "will run the firewall script."
	echo
}
