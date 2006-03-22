# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-3.5.1.ebuild,v 1.2 2006/03/22 20:15:42 danarmak Exp $
KMNAME=kdegames
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="library common to many KDE games"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=""

# For now, make sure things aren't installed GUID root (which you apparently can get with some combination of configure parameters).
# The question about the games group owning this is apparently still open?
myconf="$myconf --disable-setgid"
