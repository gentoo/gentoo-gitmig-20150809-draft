# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ksensors/ksensors-0.7.2.ebuild,v 1.3 2004/02/19 13:48:24 caleb Exp $

inherit kde
need-kde 3.0

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="mirror://sourceforge/ksensors/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"

newdepend ">=sys-apps/lm-sensors-2.6.3
	>=kde-base/kdebase-3.0"

LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack()
{
	kde_src_unpack
	cd ${S}
	rm -f config.cache
}
