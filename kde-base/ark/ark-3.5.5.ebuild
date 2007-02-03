# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-3.5.5.ebuild,v 1.10 2007/02/03 09:19:04 mr_bones_ Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Archiving tool"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

pkg_postinst(){
	kde_pkg_postinst
	elog "Please install app-arch/rar and app-arch/zip for support of rar and zip archives."
}
