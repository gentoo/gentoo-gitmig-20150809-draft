# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-8.0_pre5.ebuild,v 1.3 2006/12/03 00:10:16 beandog Exp $

inherit eutils versionator linux-mod linux-info

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

MY_PV="${PV/_/}"
MY_MAJ_PV="$(get_version_component_range 1-2 ${PV})"
DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/${MY_MAJ_PV}/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""
SLOT="0"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	linux-mod_pkg_setup
}

src_compile() {
	set_arch_to_kernel

	einfo ""
	einfo "Your kernel-sources in /usr/src/linux-${KV} must be properly configured"
	einfo "If otherwise -> build will fail."
	einfo ""

	if kernel_is 2 6; then
		emake KDIR=${KERNEL_DIR} || die "compile problem"
	else
		cp -R /usr/src/linux-${KV} ${WORKDIR}
		emake KDIR=/${WORKDIR}/linux-${KV} || die "compile problem"
	fi
}

src_install() {
	emake PREFIX=${D} install || die "install problem"

	# gentoo-ish init-script
	newinitd ${FILESDIR}/${PN}-0.7.rc ${PN} || die

	# needed by drbd startup script
	#keepdir /var/lib/drbd

	# docs
	dodoc README ChangeLog COPYING ROADMAP INSTALL
	#dodoc documentation/NFS-Server-README.txt

	# we put drbd.conf into docs
	# it doesnt make sense to install a default conf in /etc
	# put it to the docs
	rm -f ${D}/etc/drbd.conf
	dodoc scripts/drbd.conf || die
	#dodoc upgrade*.txt || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge drbd when you upgrade your kernel!"
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
