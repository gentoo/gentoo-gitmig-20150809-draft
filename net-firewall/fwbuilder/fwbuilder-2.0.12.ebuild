# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-2.0.12.ebuild,v 1.9 2009/11/29 20:04:25 tcunha Exp $

inherit eutils

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE="nls"

DEPEND="~net-libs/libfwbuilder-${PV}
	nls? ( >=sys-devel/gettext-0.11.4 )
	>=dev-libs/libxslt-1.0.7"

src_compile() {
	# prevent install script from automatically stripping binaries
	# let portage do that
	sed -i -e 's/s) stripcmd="$stripprog"$/s)/' install.sh \
		|| die "sed install.sh failed"

	export QMAKESPEC="linux-g++"
	export QMAKE="${QTDIR}/bin/qmake"

	econf `use_enable nls` || die

	addwrite "${QTDIR}/etc/settings"
	emake || die "emake failed"
}

src_install() {
	emake DDIR="${D}" install || die
	insinto /usr/share/pixmaps
	doins src/gui/icons/firewall_64.png
	make_desktop_entry fwbuilder "Firewall Builder" "/usr/share/pixmaps/firewall_64.png" "System;Qt"
}

pkg_postinst() {
	echo
	elog "You need to emerge iproute2 on the machine that"
	elog "will run the firewall script."
	echo
}
