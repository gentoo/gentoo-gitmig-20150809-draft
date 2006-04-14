# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-old-tools/madwifi-old-tools-0.1417.20060128.ebuild,v 1.1 2006/04/14 13:25:27 brix Exp $

inherit toolchain-funcs

MY_P=${PN/-tools/}-r${PV:2:4}-${PV:7:8}
S=${WORKDIR}/${MY_P}/tools

DESCRIPTION="Tools for configuration of Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi.org/"
SRC_URI="http://snapshots.madwifi.org/madwifi-old/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="virtual/libc"
RDEPEND="!net-wireless/madwifi-ng-tools
		${RDEPEND}"

pkg_setup() {
	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	use ppc && TARGET=powerpc-be-eabi
}

src_unpack() {
	unpack ${A}

	# format string fix from solar
	sed -i \
		-e 's:err(1, ifr.ifr_name);:err(1, "%s", ifr.ifr_name);:g' \
		${S}/athstats.c || die

	sed -i \
		-e "s:CFLAGS=:CFLAGS+=:" \
		-e "s:LDFLAGS=:LDFLAGS+=:" \
		${S}/Makefile || die
}

src_compile() {
	ARCH=$(tc-arch-kernel)
	emake CC=$(tc-getCC) || die "emake failed"
	ARCH=$(tc-arch)
}

src_install() {
	dodir /usr/bin

	ARCH=$(tc-arch-kernel)
	make DESTDIR="${D}" BINDIR=/usr/bin install || die "make install failed"
	ARCH=$(tc-arch)
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
