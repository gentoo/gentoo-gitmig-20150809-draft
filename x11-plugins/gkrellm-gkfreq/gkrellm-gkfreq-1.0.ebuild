# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gkfreq/gkrellm-gkfreq-1.0.ebuild,v 1.4 2007/04/26 19:07:44 armin76 Exp $

inherit gkrellm-plugin

DESCRIPTION="Displays CPU's current speed in gkrellm2"
HOMEPAGE="http://www.peakunix.net/gkfreq/"
SRC_URI="http://www.peakunix.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

PLUGIN_SO=gkfreq.so

