# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ksensors/ksensors-0.7.ebuild,v 1.8 2003/05/29 09:36:48 seemant Exp $
inherit kde-base

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="http://ksensors.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"

DEPEND=">=sys-apps/lm-sensors-2.6.3
	>=kde-base/kdebase-3.0"


LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3
