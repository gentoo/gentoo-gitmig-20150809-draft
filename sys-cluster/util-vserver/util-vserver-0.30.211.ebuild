# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.211.ebuild,v 1.3 2006/12/21 22:37:48 phreak Exp $

inherit autotools eutils bash-completion

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://www.nongnu.org/util-vserver/"
SRC_URI="http://ftp.linux-vserver.org/pub/utils/${PN}/${P}.tar.bz2
	http://dev.gentoo.org/~hollow/distfiles/${PN}-patches-${PVR}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${PN}-patches-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"

IUSE="legacy"

DEPEND=">=dev-libs/dietlibc-0.28
	dev-libs/beecrypt
	net-firewall/iptables
	net-misc/vconfig
	sys-apps/iproute2
	sys-process/procps
	=sys-devel/automake-1.9*"

RDEPEND="sys-apps/iproute2
	net-misc/vconfig
	net-firewall/iptables
	dev-libs/beecrypt
	sys-process/procps"

pkg_setup() {
	if [[ -z "${VDIRBASE}" ]]; then
		einfo
		einfo "You can change the default vserver base directory (/vservers)"
		einfo "by setting the VDIRBASE environment variable."
	fi

	: ${VDIRBASE:=/vservers}

	einfo
	einfo "Using \"${VDIRBASE}\" as vserver base directory"
	einfo

	myconf="${myconf} --with-vrootdir=${VDIRBASE}"

	# default paths
	myconf="${myconf} --localstatedir=/var"
	myconf="${myconf} --with-initrddir=/etc/init.d"

	# needed for older vserver kernels not in portage (default: v13,net)
	# we provide this just for convenience for people using self-made kernels
	use legacy && myconf="${myconf} --enable-apis=compat,v11,fscompat,v13,net"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp "${WORKDIR}"/tools/* scripts/ || die "failed to copy gentoo tools"
	epatch "${WORKDIR}"/patches/*.patch

	eautomake
}

src_compile() {
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	# create the /sbin/vshelper symlink so we don't have to mess around with
	# (a) echoing stuff to /etc/sysctl.conf
	# (b) changing the default vshelper in the kernel sources.
	dosym /usr/lib/util-vserver/vshelper /sbin/vshelper

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/run/vservers.rev
	keepdir /var/run/vshelper
	keepdir /var/lock/vservers
	keepdir /var/cache/vservers

	keepdir "${VDIRBASE}"
	fperms 000 "${VDIRBASE}"

	# remove the non-gentoo init-scripts:
	rm -f "${D}"/etc/init.d/*

	# and install branded/customized init-scripts:
	doinitd "${WORKDIR}"/init.d/vservers || die "Failed to ins init.d/vservers"
	doconfd "${WORKDIR}"/conf.d/vservers || die "Failed to ins conf.d/vservers"

	# bash-completion
	dobashcompletion "${S}"/contrib/bash_completion util-vserver

	dodoc README ChangeLog NEWS AUTHORS THANKS util-vserver.spec
}

pkg_postinst() {
	einfo
	einfo "You have to run the vprocunhide command after every reboot"
	einfo "in order to setup /proc permissions correctly for vserver"
	einfo "use. An init script has been installed by this package."
	einfo "To use it you should add it to a runlevel:"
	einfo
	einfo " rc-update add vservers default"
	einfo
	einfo "This init script will also help you to start/stop your vservers"
	einfo "on reboot. See ${ROOT}etc/conf.d/vserver for details"
	ewarn
	ewarn "You should definitly fix up the barrier of your vserver"
	ewarn "base directory by using the following command in a root shell:"
	ewarn
	ewarn " setattr --barrier ${VDIRBASE}"
	ewarn
	ewarn "IMPORTANT UPGRADE WARNING:"
	ewarn
	ewarn "Since 0.30.208-r3 the vprocunhide init-script has been merged"
	ewarn "with the vservers init script. The following steps are"
	ewarn "required to keep current behaviour:"
	ewarn
	ewarn " rc-update del vprocunhide"
	ewarn " rc-update add vservers default"
	ewarn
}
