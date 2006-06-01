# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-3.5.3.ebuild,v 1.1 2006/06/01 20:49:50 flameeyes Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="library common to many KDE games"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=""

# For now, make sure things aren't installed GUID root (which you apparently can get with some combination of configure parameters).
# The question about the games group owning this is apparently still open?
myconf="$myconf --disable-setgid"
