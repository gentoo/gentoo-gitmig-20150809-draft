# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/webcomics-collector/webcomics-collector-0.5.0.ebuild,v 1.2 2004/07/18 11:44:47 dholm Exp $

inherit distutils

DESCRIPTION="python script for downloading webcomics"
HOMEPAGE="http://collector.skumleren.net/"
SRC_URI="http://collector.skumleren.net/releases/collector-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S=${WORKDIR}/collector-${PV}
