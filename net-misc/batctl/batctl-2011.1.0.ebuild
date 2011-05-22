# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batctl/batctl-2011.1.0.ebuild,v 1.3 2011/05/22 23:22:09 xmw Exp $

EAPI=3

inherit linux-info toolchain-funcs

DESCRIPTION="BATMAN advanced control and management tool"
HOMEPAGE="http://www.open-mesh.org/"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	if ( linux_config_exists && linux_chkconfig_present BATMAN_ADV ) \
		|| ! has_version net-misc/batman-adv ; then
		ewarn "You need the batman-adv kernel module,"
		ewarn "either from the kernel tree or via net-misc/batman-adv"
	fi
}

src_prepare() {
	sed -e "/^CFLAGS/s: -O[^[:space:]]* : :" \
		-e "/^CFLAGS/s: -g[^[:space:]]* : :" \
		-e "s: -j \$(NUM_CPUS) : :" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" V=1 || die
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die
	dodoc README || die
	doman man/* || die
}
