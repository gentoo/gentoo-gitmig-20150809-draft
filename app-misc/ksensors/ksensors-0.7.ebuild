# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp
inherit kde-base

LICENSE="GPL-2"
DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="http://ksensors.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"

DEPEND=">=sys-apps/lm_sensors-2.6.3
	>=kde-base/kdebase-3.0"

need-kde 3

