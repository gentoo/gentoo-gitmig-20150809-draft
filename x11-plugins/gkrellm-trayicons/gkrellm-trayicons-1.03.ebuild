# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-trayicons/gkrellm-trayicons-1.03.ebuild,v 1.7 2007/05/26 12:55:14 opfer Exp $

inherit gkrellm-plugin

DESCRIPTION="Configurable Tray Icons for GKrellM"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/trayicons/"
SRC_URI="http://sweb.cz/tripie/gkrellm/trayicons/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

PLUGIN_SO=trayicons.so

