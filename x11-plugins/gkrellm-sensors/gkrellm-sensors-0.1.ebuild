# Copyright 2002 Robin Cull
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-sensors/gkrellm-sensors-0.1.ebuild,v 1.4 2003/05/29 09:38:48 seemant Exp $

MY_P=${P/gkrellm-/gklm}
S=${WORKDIR}/gklmsensors
DESCRIPTION="A GKrellm plugin for monitoring lm_sensors"
HOMEPAGE="http://sourceforge.net/projects/gklmsensors"
SRC_URI="mirror://sourceforge/gklmsensors/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
	>=sys-apps/lm-sensors-2.6.3"

src_compile() {
	emake all || die
}

src_install() {
	insinto /usr/lib/gkrellm/plugins
	doins sensors.so	
}
