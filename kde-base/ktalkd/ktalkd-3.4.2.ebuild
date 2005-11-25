# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.4.2.ebuild,v 1.6 2005/11/25 10:20:49 cryos Exp $

KMNAME=kdenetwork
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="~alpha amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"
