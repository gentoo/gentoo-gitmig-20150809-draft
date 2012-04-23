# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mda-lv2/mda-lv2-1.0.0.ebuild,v 1.1 2012/04/23 13:27:59 aballier Exp $

EAPI=4

inherit waf-utils

DESCRIPTION="LV2 port of the MDA plugins by Paul Kellett"
HOMEPAGE="http://drobilla.net/software/mda-lv2/"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/lv2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( "README" )
