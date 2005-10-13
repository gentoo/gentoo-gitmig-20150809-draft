# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdcop/kdcop-3.4.1.ebuild,v 1.10 2005/10/13 00:09:51 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: graphical DCOP browser/client"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
KMNODOCS="true"

