# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/imagekits/imagekits-0.6.ebuild,v 1.5 2006/03/26 12:10:09 grobian Exp $

inherit gnustep

S=${WORKDIR}/${PN/imagek/ImageK}

DESCRIPTION="ImageKits is a collection of frameworks to support the applications of ImageApps."
# 26 Mar 2006: http://mac.wms-network.de/ has redirect, but page seems
#              dead
HOMEPAGE="http://mac.wms-network.de/gnustep/imageapps/imagekits/imagekits.html"
SRC_URI="http://mac.wms-network.de/gnustep/imageapps/imagekits/${P/imagek/ImageK}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"
