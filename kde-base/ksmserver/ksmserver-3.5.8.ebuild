# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksmserver/ksmserver-3.5.8.ebuild,v 1.1 2007/10/19 23:32:28 philantrop Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-07.tar.bz2"

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility dbus hal"

KMEXTRACTONLY="kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KMNODOCS=true

DEPEND="dbus? ( sys-apps/dbus )
		hal? ( sys-apps/hal )"

src_compile() {
	myconf="${myconf}
			$(use_enable hal)
			$(use_enable dbus)"

	kde-meta_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	if use dbus && use hal ; then
		echo
		elog "If you don't see any icons next to the suspend/hibernate buttons,"
		elog "make sure you use an iconset that provides the files"
		elog "\"suspend.png\" and \"hibernate.png\"."
		echo
	fi
}
