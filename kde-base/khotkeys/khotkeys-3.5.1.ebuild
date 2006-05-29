# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khotkeys/khotkeys-3.5.1.ebuild,v 1.9 2006/05/29 20:26:30 weeve Exp $

KMNAME=kdebase
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
