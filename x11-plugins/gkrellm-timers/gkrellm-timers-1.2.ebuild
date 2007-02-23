# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-timers/gkrellm-timers-1.2.ebuild,v 1.1 2007/02/23 01:32:10 lack Exp $

inherit multilib

MY_P=${P/-/_}
DESCRIPTION="A GKrellM2 plugin that allows the user to define multiple timers"
SRC_URI="http://triq.net/gkrellm_timers/${MY_P}.tar.gz"
HOMEPAGE="http://triq.net/gkrellm_timers"

DEPEND="=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	doexe gkrellm_timers.so
	dodoc README ChangeLog
}
