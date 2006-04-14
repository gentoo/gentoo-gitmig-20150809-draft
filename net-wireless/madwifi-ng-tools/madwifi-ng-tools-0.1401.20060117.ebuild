# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-ng-tools/madwifi-ng-tools-0.1401.20060117.ebuild,v 1.1 2006/04/14 13:41:51 brix Exp $

inherit toolchain-funcs

MY_P=madwifi-ng-r${PV:2:4}-${PV:7:8}
S=${WORKDIR}/${MY_P}/tools

DESCRIPTION="Tools for configuration of Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi.org/"
SRC_URI="http://snapshots.madwifi.org/madwifi-ng/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="udev"
DEPEND="virtual/libc"
RDEPEND="!net-wireless/madwifi-old-tools
		${DEPEND}"

src_unpack() {
	unpack ${A}

	# format string fix from solar
	sed -i -e 's:err(1, ifr.ifr_name);:err(1, "%s", ifr.ifr_name);:g' ${S}/athstats.c

	sed -i \
		-e "s:CC =.*:CC = $(tc-getCC):" \
		-e "s:CFLAGS=:CFLAGS+=:" \
		-e "s:LDFLAGS=:LDFLAGS+=:" \
		${S}/Makefile || die
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin MANDIR=/usr/share/man install || die "make install failed"

	dodir /sbin
	mv "${D}"/usr/bin/wlanconfig "${D}"/sbin

	if use udev; then
		insinto /etc/udev/rules.d/
		newins ${FILESDIR}/${P}-udev.rules 65-madwifi.rules || die
	fi
}

pkg_postinst() {
	einfo
	einfo "Interfaces (athX) needs to be added using wlanconfig(8) after"
	einfo "loading madwifi-driver."
	einfo
	if use udev; then
		einfo "Example udev rules for automatically taking care of this has been"
		einfo "installed to:"
		einfo
		einfo "  /etc/udev/rules.d/65-madwifi.rules"
		einfo
		einfo "Modify these rules to match your configuration and either run 'udevstart'"
		einfo "or reboot for the rules to take effect."
		einfo
	fi
}
