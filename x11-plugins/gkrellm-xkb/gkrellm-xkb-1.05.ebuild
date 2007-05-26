# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-xkb/gkrellm-xkb-1.05.ebuild,v 1.5 2007/05/26 14:11:11 opfer Exp $

inherit gkrellm-plugin

DESCRIPTION="XKB keyboard switcher for gkrellm2"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/xkb/"
SRC_URI="http://sweb.cz/tripie/gkrellm/xkb/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

PLUGIN_SO=xkb.so

