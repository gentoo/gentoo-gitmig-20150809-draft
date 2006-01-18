# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/fetch/fetch-0.1.1.ebuild,v 1.2 2006/01/18 20:41:36 vanquirius Exp $

inherit rox

MY_PN="Fetch"
DESCRIPTION="Fetch - an downloader for the ROX Desktop"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/fetch.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ROX_LIB_VER=2.0.0

APPNAME=Fetch
S="${WORKDIR}"
