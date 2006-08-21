# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-3.5.1.ebuild,v 1.8 2006/08/21 19:52:16 corsair Exp $
KMNAME=kdeadmin
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
DEPEND=""

PATCHES="$FILESDIR/never-disable.diff"
