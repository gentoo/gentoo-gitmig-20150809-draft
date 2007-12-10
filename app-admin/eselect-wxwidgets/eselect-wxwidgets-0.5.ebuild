# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-wxwidgets/eselect-wxwidgets-0.5.ebuild,v 1.5 2007/12/10 07:03:01 jer Exp $

DESCRIPTION="Manage the system default for wxWidgets packages."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="!<=x11-libs/wxGTK-2.6.4.0-r1"
RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}"/wxwidgets.eselect-${PV} wxwidgets.eselect \
		|| die "Failed installing module"

	newbin "${FILESDIR}"/wx-config-${PV} wx-config
	newbin "${FILESDIR}"/wxrc-${PV} wxrc

	keepdir /var/lib/wxwidgets
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/var/lib/wxwidgets/current ]]; then
		echo 'WXCONFIG="none"' > "${ROOT}"/var/lib/wxwidgets/current
	fi
}
