# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-xkb/gkrellm-xkb-1.05.ebuild,v 1.4 2007/03/12 16:38:42 lack Exp $

inherit gkrellm-plugin

DESCRIPTION="XKB keyboard switcher for gkrellm2"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/xkb/"
SRC_URI="http://sweb.cz/tripie/gkrellm/xkb/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

PLUGIN_SO=xkb.so

