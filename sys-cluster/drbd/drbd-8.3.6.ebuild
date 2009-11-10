# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-8.3.6.ebuild,v 1.1 2009/11/10 11:46:08 wschlich Exp $

EAPI="2"

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

src_configure() {
	# TODO FIXME: add USE flags?
	econf \
		--localstatedir=/var \
		--with-utils \
		--without-km \
		--without-udev \
		--with-xen \
		--without-pacemaker \
		--with-heartbeat \
		--without-rgmanager \
		--without-bashcompletion \
		--with-distro=gentoo \
		|| die "configure failed"
}

src_compile() {
	# only compile the tools
	emake -j1 OPTFLAGS="${CFLAGS}" tools || die "compilation failed"
}

src_install() {
	# only install the tools
	emake DESTDIR="${D}" install-tools || die "installation failed"

	# install our own init script
	newinitd "${FILESDIR}"/${PN}-8.0.rc ${PN} || die

	# manually install udev rules
	insinto /etc/udev/rules.d
	newins scripts/drbd.rules 65-drbd.rules || die

	# manually install bash-completion script
	insinto /usr/share/bash-completion
	newins scripts/drbdadm.bash_completion drbdadm

	# install the docs
	dodoc README ChangeLog

	# it doesnt make sense to install a default conf in /etc,
	# so we put it to the docs
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
