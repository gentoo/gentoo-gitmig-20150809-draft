# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrelltop/gkrelltop-2.2.11-r1.ebuild,v 1.5 2012/08/30 00:28:32 lack Exp $

EAPI=4
inherit gkrellm-plugin toolchain-funcs

DESCRIPTION="a GKrellM2 plugin which displays the top three processes"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gkrelltop"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc ~sparc x86"
IUSE="X"

PLUGIN_SERVER_SO=gkrelltopd.so
PLUGIN_SO=gkrelltop.so

S="${WORKDIR}/${P}.orig"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e "s:/usr/bin/gcc:$(tc-getCC) \$(CFLAGS):" \
		-e 's/-shared/$(LDFLAGS) &/' \
		Makefile || die
}

src_compile() {
	use X || TARGET="server"
	emake ${TARGET}
}

pkg_postinst() {
	einfo "To enable the gkrelltopd server plugin, you must add the following"
	einfo "line to /etc/gkrellmd.conf:"
	einfo "\tplugin-enable gkrelltopd"
}
