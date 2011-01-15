# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mozplugger/mozplugger-1.14.2.ebuild,v 1.3 2011/01/15 10:37:14 mgorny Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="Configurable browser plugin to launch streaming media players."
SRC_URI="http://mozplugger.mozdev.org/files/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.14.2-fix-nsplugin-install.patch"
	sed -i "s:libprefix=.*:libprefix=/$(get_libdir):" Makefile
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		XCFLAGS="-fPIC -Wall" \
		COMMON_LDFLAGS="${LDFLAGS}" \
		all || die
}

src_install() {
	emake root="${D}" install || die
	dodoc ChangeLog README
}
