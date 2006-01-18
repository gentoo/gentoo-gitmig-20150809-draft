# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/fetch/fetch-0.0.3.ebuild,v 1.4 2006/01/18 20:41:36 vanquirius Exp $

inherit rox

DESCRIPTION="Fetch - an downloader for the ROX Desktop"

MY_PN="Fetch"

HOMEPAGE="http://www.kerofin.demon.co.uk/rox/fetch.html"

SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

ROX_LIB_VER=1.9.11

APPNAME=Fetch

S="${WORKDIR}"
