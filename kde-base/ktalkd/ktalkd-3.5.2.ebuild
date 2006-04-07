# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.5.2.ebuild,v 1.3 2006/04/07 11:54:44 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"