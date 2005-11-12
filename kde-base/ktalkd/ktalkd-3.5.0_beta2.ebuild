# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.5.0_beta2.ebuild,v 1.3 2005/11/12 15:49:33 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="~amd64 ~x86"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"