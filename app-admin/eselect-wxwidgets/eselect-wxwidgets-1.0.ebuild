# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-wxwidgets/eselect-wxwidgets-1.0.ebuild,v 1.1 2009/07/01 07:16:25 dirtyepic Exp $

DESCRIPTION="Eselect module and wrappers for wxWidgets"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!<=x11-libs/wxGTK-2.6.4.0-r2"
RDEPEND="app-admin/eselect"

WXWRAP_VER=1

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}"/wxwidgets.eselect-0.8 wxwidgets.eselect \
		|| die "Failed installing module"

	insinto /usr/share/aclocal
	doins "${FILESDIR}"/wxwin.m4

	newbin "${FILESDIR}"/wx-config-${WXWRAP_VER} wx-config
	newbin "${FILESDIR}"/wxrc-${WXWRAP_VER} wxrc

	keepdir /var/lib/wxwidgets
	keepdir /usr/share/bakefile/presets
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/var/lib/wxwidgets/current ]]; then
		echo 'WXCONFIG="none"' > "${ROOT}"/var/lib/wxwidgets/current
	fi

	echo
	elog "By default the system wxWidgets profile is set to \"none\"."
	elog
	elog "It is unnecessary to change this unless you are doing development work"
	elog "with wxGTK outside of portage.  The package manager ignores the profile"
	elog "setting altogether."
	echo
}
