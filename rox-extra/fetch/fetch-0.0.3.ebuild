# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/fetch/fetch-0.0.3.ebuild,v 1.2 2005/03/05 15:02:22 josejx Exp $

DESCRIPTION="Fetch - an downloader for the ROX Desktop"

MY_PN="Fetch"

HOMEPAGE="http://www.kerofin.demon.co.uk/rox/fetch.html"

SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

ROX_LIB_VER=1.9.11

APPNAME=Fetch

S=${WORKDIR}

inherit rox
