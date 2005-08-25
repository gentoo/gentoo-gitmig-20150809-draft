# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/imagekits/imagekits-0.6.ebuild,v 1.4 2005/08/25 19:03:48 swegener Exp $

inherit gnustep

S=${WORKDIR}/${PN/imagek/ImageK}

DESCRIPTION="ImageKits is a collection of frameworks to support the applications of ImageApps."
HOMEPAGE="http://mac.wms-network.de/gnustep/imageapps/imagekits/imagekits.html"
SRC_URI="http://mac.wms-network.de/gnustep/imageapps/imagekits/${P/imagek/ImageK}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"
