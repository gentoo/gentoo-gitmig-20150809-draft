# Copyright 2002 Robin Cull
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gklmsensors/gklmsensors-0.1.ebuild,v 1.1 2002/08/30 07:44:13 seemant Exp $

S=${WORKDIR}/gklmsensors
DESCRIPTION="A GKrellm plugin for monitoring lm_sensors"
HOMEPAGE="http://sourceforge.net/projects/gklmsensors"
SRC_URI="mirror://sourceforge/gklmsensors/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*
	>=sys-apps/lm_sensors-2.6.3"

src_compile() {
	emake all || die
}

src_install() {
	insinto /usr/lib/gkrellm/plugins
	doins sensors.so	
}
