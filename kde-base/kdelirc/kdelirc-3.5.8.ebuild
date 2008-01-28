# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelirc/kdelirc-3.5.8.ebuild,v 1.2 2008/01/28 20:55:28 philantrop Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDElirc - KDE Frontend to lirc"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	app-misc/lirc"
