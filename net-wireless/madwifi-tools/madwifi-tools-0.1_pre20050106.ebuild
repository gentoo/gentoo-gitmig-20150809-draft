# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-tools/madwifi-tools-0.1_pre20050106.ebuild,v 1.1 2005/01/06 21:26:50 solar Exp $

# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/madwifi co madwifi

DESCRIPTION="Wireless tools for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"

SRC_URI="mirror://gentoo/${P/tools/driver}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/libc sys-apps/sed"
RDEPEND=""
S=${WORKDIR}

pkg_setup() {
	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	export TARGET
	sed -i -e 's/err(1, ifr.ifr_name);/err(1, "%s", ifr.ifr_name);'/g tools/athstats.c
}

src_compile() {
	einfo "building tools..."
	cd ${S}/tools || die "failed to chdir to ${S}/tools"
	make clean || :
	emake TARGET="${TARGET}" LDFLAGS="${CFLAGS} ${LDFLAGS}" \
		|| die "failed to build the driver tools"
}

src_install() {
	dodoc README COPYRIGHT
	cd ${S}/tools
	insinto /usr
	for bin in 80211stats ath{chans,ctrl,key,stats}; do
		[ -e ${bin} ] && dobin ${bin}
	done
}
