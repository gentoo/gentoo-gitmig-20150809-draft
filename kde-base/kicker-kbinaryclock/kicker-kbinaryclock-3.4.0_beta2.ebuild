# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker-kbinaryclock/kicker-kbinaryclock-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:18 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kicker-applets/kbinaryclock"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kicker applet displaying a clock in binary"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kicker)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-docs-kicker-applets)"
OLDDEPEND="~kde-base/kicker-$PV ~kde-base/kdeaddons-docs-kicker-applets-$PV"


