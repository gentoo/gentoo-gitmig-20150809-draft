# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/librss/librss-3.5.0.ebuild,v 1.9 2006/04/07 11:38:27 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE rss library"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""