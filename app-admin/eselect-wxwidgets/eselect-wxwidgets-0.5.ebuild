# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-wxwidgets/eselect-wxwidgets-0.5.ebuild,v 1.1 2007/11/18 21:21:09 dirtyepic Exp $

DESCRIPTION="Manage the system default for wxWidgets packages."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
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
