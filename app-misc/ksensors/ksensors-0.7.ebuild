# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ksensors/ksensors-0.7.ebuild,v 1.9 2003/09/25 20:08:04 caleb Exp $
inherit kde

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="http://ksensors.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"

DEPEND=">=sys-apps/lm-sensors-2.6.3
	>=kde-base/kdebase-3.0"


LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

src_unpack()
{
	kde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/startupcrash.diff
}
