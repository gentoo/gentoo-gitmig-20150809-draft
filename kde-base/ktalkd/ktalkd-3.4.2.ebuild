# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.4.2.ebuild,v 1.8 2005/12/10 07:02:41 chriswhite Exp $

KMNAME=kdenetwork
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"
