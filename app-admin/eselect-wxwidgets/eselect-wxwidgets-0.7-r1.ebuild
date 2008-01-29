# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-wxwidgets/eselect-wxwidgets-0.7-r1.ebuild,v 1.6 2008/01/29 19:21:12 nixnut Exp $

DESCRIPTION="Manage the system default for wxWidgets packages."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="!<=x11-libs/wxGTK-2.6.4.0-r2"
RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}"/wxwidgets.eselect-${PV} wxwidgets.eselect \
		|| die "Failed installing module"

	insinto /usr/share/aclocal
	doins "${FILESDIR}"/wxwin.m4

	newbin "${FILESDIR}"/wx-config-${PV} wx-config
	newbin "${FILESDIR}"/wxrc-${PV} wxrc

	keepdir /var/lib/wxwidgets
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/var/lib/wxwidgets/current ]]; then
		echo 'WXCONFIG="none"' > "${ROOT}"/var/lib/wxwidgets/current
	fi

	echo
	elog "By default your system wxWidgets profile is set to \"none\"."
	elog
	elog "You will need to select a profile using \`eselect wxwidgets\` to"
	elog "use wxGTK outside of portage.  If you do not plan on building"
	elog "packages or doing development work with wxGTK outside of portage"
	elog "then you can safely leave this set to \"none\"."
	echo
}
