# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkholidays/libkholidays-3.4.0_rc1.ebuild,v 1.3 2005/03/18 14:36:53 greg_g Exp $

KMNAME=kdepim

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE library to compute holidays."
KEYWORDS="~x86 ~amd64"
IUSE=""


