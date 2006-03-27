# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.4.2.ebuild,v 1.10 2006/03/27 14:02:23 agriffis Exp $

KMNAME=kdenetwork
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"
