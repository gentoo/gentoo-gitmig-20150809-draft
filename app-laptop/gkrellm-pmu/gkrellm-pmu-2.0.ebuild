# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/gkrellm-pmu/gkrellm-pmu-2.0.ebuild,v 1.7 2004/11/27 13:45:08 dams Exp $

DESCRIPTION="GKrellM2 plugin for battery display on Apple machines"
HOMEPAGE="http://pbbuttons.sourceforge.net/projects/gkrellm-pmu/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="ppc"
IUSE=""

DEPEND="=app-admin/gkrellm-2*"

src_install() {
	dodir /usr/lib/gkrellm2/plugins
	emake DESTDIR=${D} PLUGIN_INSTALL="${D}/usr/lib/gkrellm2/plugins" install || die
	dodoc ChangeLog INSTALL README
}
