# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lv2-ui/lv2-ui-2.4.ebuild,v 1.1 2012/01/07 15:17:35 aballier Exp $

EAPI=3
inherit waf-utils

DESCRIPTION="Generic UI interface for LV2 plugins"
HOMEPAGE="http://lv2plug.in/ns/extensions/ui"
SRC_URI="http://lv2plug.in/spec/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=media-libs/lv2core-6.0"

DOCS=( "NEWS" )
