# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksensors/ksensors-0.7.2-r1.ebuild,v 1.4 2005/02/27 12:34:17 brix Exp $

inherit kde eutils

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="mirror://sourceforge/ksensors/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 -ppc"

IUSE=""
SLOT="0"

DEPEND=">=sys-apps/lm_sensors-2.6.3
	|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.0 )"

need-kde 3.0

src_unpack()
{
	kde_src_unpack
	cd ${S}
	rm -f config.cache
	epatch ${FILESDIR}/${P}-scaling.diff
}
