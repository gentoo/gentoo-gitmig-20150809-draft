# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktouch/ktouch-3.5.0.ebuild,v 1.6 2006/03/28 00:56:24 agriffis Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"

KMEXTRACTONLY="libkdeedu/kdeeduplot"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot"
