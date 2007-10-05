# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-0.7.24-r1.ebuild,v 1.1 2007/10/05 14:02:51 xmerlin Exp $

inherit eutils versionator

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

MY_PV="${PV/_/}"
MY_MAJ_PV="$(get_version_component_range 1-2 ${PV})"
DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/${MY_MAJ_PV}/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""

DEPEND=""
RDEPEND=""
PDEPEND="~sys-cluster/drbd-kernel-${PV}"

SLOT="0"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	emake -j1 tools || die "compile problem"
}

src_install() {
	emake PREFIX=${D} install-tools || die "install problem"

	# gentoo-ish init-script
	newinitd ${FILESDIR}/${PN}-0.7.rc ${PN} || die

	# needed by drbd startup script
	#keepdir /var/lib/drbd

	# docs
	dodoc README ChangeLog COPYING
	dodoc documentation/NFS-Server-README.txt

	# we put drbd.conf into docs
	# it doesnt make sense to install a default conf in /etc
	# put it to the docs
	rm -f ${D}/etc/drbd.conf
	dodoc scripts/drbd.conf || die
	dodoc upgrade_0.6.x_to_0.7.0.txt upgrade_0.7.0_to_0.7.1.txt || die
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
