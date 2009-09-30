# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-8.3.2.ebuild,v 1.2 2009/09/30 14:00:20 xmerlin Exp $

inherit eutils versionator

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

MY_MAJ_PV="$(get_version_component_range 1-2 ${PV})"
DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/${MY_MAJ_PV}/${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""

DEPEND=""
RDEPEND=""
PDEPEND="~sys-cluster/drbd-kernel-${PV}"

SLOT="0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/drbd-8.3.2-bitsperlong.h.patch || die

	# disable udev detect / installation
	sed -i -e 's/install: install-most install-udev-rules/install: install-most/g' scripts/Makefile || die
}

src_compile() {
	emake -j1 OPTFLAGS="${CFLAGS}" tools || die "compile problem"
}

src_install() {
	emake PREFIX="${D}" install-tools || die "install problem"

	# gentoo-ish init-script
	newinitd "${FILESDIR}"/${PN}-8.0.rc ${PN} || die

	insinto /etc/udev/rules.d
	newins scripts/drbd.rules 65-drbd.rules || die

	# docs
	dodoc README ChangeLog ROADMAP INSTALL

	# we put drbd.conf into docs
	# it doesnt make sense to install a default conf in /etc
	# put it to the docs
	rm -f "${D}"/etc/drbd.conf
	dodoc scripts/drbd.conf || die
}

pkg_postinst() {
	einfo ""
	einfo "Please copy and gunzip the configuration file"
	einfo "from /usr/share/doc/${PF}/drbd.conf.gz to /etc"
	einfo "and edit it to your needs. Helpful commands:"
	einfo "man 5 drbd.conf"
	einfo "man 8 drbdsetup"
	einfo "man 8 drbdadm"
	einfo "man 8 drbddisk"
	einfo "man 8 drbdmeta"
	einfo ""
}
