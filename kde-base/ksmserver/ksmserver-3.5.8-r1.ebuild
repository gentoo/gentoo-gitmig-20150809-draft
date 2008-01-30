# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksmserver/ksmserver-3.5.8-r1.ebuild,v 1.5 2008/01/30 17:24:04 ranger Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-07.tar.bz2"

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRACTONLY="kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KMNODOCS=true

EPATCH_EXCLUDE="ksmserver-3.5.8-ksmserver_suspend.diff
				ksmserver-3.5.8-suspend_configure.diff"

PATCHES="${FILESDIR}/${P}-gdm_interop_197133.patch"
