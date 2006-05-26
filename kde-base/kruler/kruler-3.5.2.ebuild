# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kruler/kruler-3.5.2.ebuild,v 1.6 2006/05/26 16:21:52 corsair Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A screen ruler for the K Desktop Environment"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""