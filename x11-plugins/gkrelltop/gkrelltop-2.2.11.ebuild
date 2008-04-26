# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrelltop/gkrelltop-2.2.11.ebuild,v 1.1 2008/04/26 22:46:43 lack Exp $

inherit gkrellm-plugin

DESCRIPTION="a GKrellM2 plugin which displays the top three processes"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gkrelltop"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="X"

PLUGIN_SERVER_SO=gkrelltopd.so
PLUGIN_SO=gkrelltop.so

S="${WORKDIR}/${P}.orig"

DEPEND="=dev-libs/glib-2*
	X? ( =x11-libs/gtk+-2* )"

src_compile() {
	econf
	use X || TARGET="server"
	emake ${TARGET}
}

pkg_postinst() {
	einfo "To enable the gkrelltopd server plugin, you must add the following"
	einfo "line to /etc/gkrellmd.conf:"
	einfo "\tplugin-enable gkrelltopd"
}
