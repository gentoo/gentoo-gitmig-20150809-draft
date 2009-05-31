# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-timers/gkrellm-timers-1.3.ebuild,v 1.2 2009/05/31 15:02:44 maekke Exp $

inherit gkrellm-plugin

MY_P=${P/-/_}
DESCRIPTION="A GKrellM2 plugin that allows the user to define multiple timers"
SRC_URI="http://triq.net/gkrellm_timers/${MY_P}.tar.gz"
HOMEPAGE="http://triq.net/gkrellm_timers.html"
IUSE=

DEPEND="=app-admin/gkrellm-2*"
RDEPEND=${DEPEND}

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"

S="${WORKDIR}/${MY_P}"

PLUGIN_SO=gkrellm_timers.so
