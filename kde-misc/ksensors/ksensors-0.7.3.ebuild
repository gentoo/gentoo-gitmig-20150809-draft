# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksensors/ksensors-0.7.3.ebuild,v 1.8 2009/10/12 09:28:10 abcd Exp $

inherit kde

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="mirror://sourceforge/ksensors/${P}.tar.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-apps/lm_sensors-2.6.3"

RDEPEND="${DEPEND}"

need-kde 3

src_unpack()
{
	kde_src_unpack
	rm -f "${S}"/config.cache
}
