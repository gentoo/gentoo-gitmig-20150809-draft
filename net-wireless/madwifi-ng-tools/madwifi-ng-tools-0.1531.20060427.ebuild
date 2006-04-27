# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-ng-tools/madwifi-ng-tools-0.1531.20060427.ebuild,v 1.1 2006/04/27 16:29:28 brix Exp $

inherit toolchain-funcs

MY_P=${PN/-tools/}-r${PV:2:4}-${PV:7:8}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Next Generation tools for configuration of Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi.org/"
SRC_URI="http://snapshots.madwifi.org/madwifi-ng/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="virtual/libc"
RDEPEND="!net-wireless/madwifi-old-tools
		${DEPEND}"

src_unpack() {
	unpack ${A}

	# format string fix from solar
	sed -i \
		-e 's:err(1, ifr.ifr_name);:err(1, "%s", ifr.ifr_name);:g' \
		${S}/tools/athstats.c || die

	sed -i \
		-e "s:CC =.*:CC = $(tc-getCC):" \
		-e "s:CFLAGS=:CFLAGS+=:" \
		-e "s:LDFLAGS=:LDFLAGS+=:" \
		${S}/tools/Makefile || die
}

src_compile() {
	emake tools || die "emake tools failed"
}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin MANDIR=/usr/share/man STRIP=echo \
		install-tools || die "make install-tools failed"

	dodir /sbin
	mv "${D}"/usr/bin/wlanconfig "${D}"/sbin
}

pkg_postinst() {
	if [ -e "${ROOT}"/etc/udev/rules.d/65-madwifi.rules ]; then
		ewarn
		ewarn "The udev rules for creating interfaces (athX) are no longer needed."
		ewarn
		ewarn "You should manually remove the /etc/udev/rules.d/65-madwifi.rules file"
		ewarn "and either run 'udevstart' or reboot for the changes to take effect."
		ewarn
	fi
}
