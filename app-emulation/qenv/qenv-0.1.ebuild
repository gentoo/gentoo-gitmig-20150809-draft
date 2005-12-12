# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qenv/qenv-0.1.ebuild,v 1.1 2005/12/12 20:00:22 robbat2 Exp $

inherit libtool eutils

DESCRIPTION="Pool of machines handler for QEMU"
HOMEPAGE="http://virutass.net/software/qemu/"
SRC_URI="http://virutass.net/software/qemu/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# these should in RDEPEND only, but configure fails without them
RDEPEND=">=app-emulation/qemu-0.7.2
		net-firewall/iptables
		net-misc/bridge-utils
		app-admin/sudo
		net-dns/dnsmasq"
DEPEND="${DEPEND}
		sys-devel/autoconf
		sys-devel/automake"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch  ${FILESDIR}/${PN}-0.1-qemu-0.7.2.patch \
	|| die "failed to update for qemu-0.7.2"
	cd ${S}
	for i in 'autoconf' 'automake' 'libtoolize --copy --force' ; do
		einfo "Doing $i"
		${i} || die "Failed: $i"
	done;
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc README AUTHORS
}
