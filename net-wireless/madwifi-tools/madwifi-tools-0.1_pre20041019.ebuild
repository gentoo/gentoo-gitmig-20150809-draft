# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-tools/madwifi-tools-0.1_pre20041019.ebuild,v 1.1 2004/10/19 18:57:53 solar Exp $

# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/madwifi co madwifi

DESCRIPTION="Wireless tools for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"

SRC_URI="mirror://gentoo/${P/tools/driver}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}


src_compile() {
	einfo "building tools..."
	cd ${S}/tools || die "failed to chdir to ${S}/tools"
	make clean || :
	emake LDFLAGS="${CFLAGS} ${LDFLAGS}" || die "failed to build the driver tools"
}

src_install() {
	dodoc README COPYRIGHT
	cd ${S}/tools
	insinto /usr
	for bin in 80211stats ath{chans,ctrl,key,stats}; do
		[ -e ${bin} ] && dobin ${bin}
	done
}
