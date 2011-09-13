# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/npapi-sdk/npapi-sdk-0.27.ebuild,v 1.1 2011/09/13 16:34:06 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="NPAPI headers bundle"
HOMEPAGE="https://github.com/mgorny/npapi-sdk/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""
