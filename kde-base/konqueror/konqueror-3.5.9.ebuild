# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-3.5.9.ebuild,v 1.4 2008/05/12 20:03:13 ranger Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="branding java kdehiddenvisibility"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	java? ( >=virtual/jre-1.4 )"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h

pkg_preinst() {
	kde_pkg_preinst

	# We need to symlink here, as kfmclient freaks out completely,
	# if it does not find konqueror.desktop in the legacy path.
	dodir "${PREFIX}"/share/applications/kde
	dosym ../../applnk/konqueror.desktop "${PREFIX}"/share/applications/kde/konqueror.desktop
}

src_install() {
	kde_src_install

	if use branding ; then
		dodir "${PREFIX}"/share/services/searchproviders
		insinto "${PREFIX}"/share/services/searchproviders
		doins "${WORKDIR}"/patches/Gentoo_{Forums,Bugzilla}.desktop
	fi
}

pkg_postinst() {
	kde_pkg_postinst

	if use branding ; then
		echo
		elog "We've added Gentoo-related web shortcuts:"
		elog "- gb           Gentoo Bugzilla searching"
		elog "- gf           Gentoo Forums searching"
#		elog "- gp           Gentoo Package searching"
		echo
		elog "You'll have to activate them in 'Configure Konqueror...'."
	fi
	echo
	elog "If you can't open new ${PN} windows and get something like"
	elog "'WARNING: Outdated database found' when starting ${PN} in a console, run"
	elog "kbuildsycoca as the user you're running KDE under."
	elog "This is NOT a bug."
	echo
}
