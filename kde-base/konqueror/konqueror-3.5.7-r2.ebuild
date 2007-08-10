# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-3.5.7-r2.ebuild,v 1.6 2007/08/10 16:07:11 angelos Exp $

KMNAME=kdebase
# Note: we need >=kdelibs-3.3.2-r1, but we don't want 3.3.3!
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="branding java kdehiddenvisibility"

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)"

RDEPEND="${DEPEND}
	$(deprange $PV $MAXKDEVER kde-base/kcontrol)
	$(deprange $PV $MAXKDEVER kde-base/kdebase-kioslaves)
	$(deprange $PV $MAXKDEVER kde-base/kfind)
	java? ( >=virtual/jre-1.4 )"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h

pkg_preinst() {
	kde_pkg_preinst

	# We need to symlink here, as kfmclient freaks out completely,
	# if it does not find konqueror.desktop in the legacy path.
	dodir ${PREFIX}/share/applications/kde
	dosym ../../applnk/konqueror.desktop ${PREFIX}/share/applications/kde/konqueror.desktop
}

src_install() {
	kde_src_install

	if use branding ; then
		dodir ${PREFIX}/share/services/searchproviders
		insinto ${PREFIX}/share/services/searchproviders
		doins ${WORKDIR}/patches/*.desktop
	fi
}

pkg_postinst() {
	kde_pkg_postinst

	if use branding ; then
		echo
		elog "We've added three Gentoo-related web shortcuts:"
		elog "- gb           Gentoo Bugzilla searching"
		elog "- gf           Gentoo Forums searching"
		elog "- gp           Gentoo Package searching"
		echo
		elog "You'll have to activate them in 'Configure Konqueror...'."
		echo
		elog "If you can't open new ${PN} windows and get something like"
		elog "'WARNING: Outdated database found' when starting ${PN} in a console, run"
		elog "kbuildsycoca as the user you're running KDE under."
		elog "This is NOT a bug."
		echo
	fi
}
