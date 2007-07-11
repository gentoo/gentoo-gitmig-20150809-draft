# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-timers/gkrellm-timers-1.2.ebuild,v 1.3 2007/07/11 20:39:22 mr_bones_ Exp $

inherit gkrellm-plugin

MY_P=${P/-/_}
DESCRIPTION="A GKrellM2 plugin that allows the user to define multiple timers"
SRC_URI="http://triq.net/gkrellm_timers/${MY_P}.tar.gz"
HOMEPAGE="http://triq.net/gkrellm_timers"

DEPEND="=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${MY_P}"

PLUGIN_SO=gkrellm_timers.so
