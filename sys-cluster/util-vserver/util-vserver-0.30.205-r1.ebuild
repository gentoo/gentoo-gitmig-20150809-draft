# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.205-r1.ebuild,v 1.1 2005/04/07 14:23:52 hollow Exp $

inherit eutils

DESCRIPTION="Linux-VServer admin utilities"
SRC_URI="http://www.13thfloor.at/~ensc/util-vserver/files/alpha/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/util-vserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="glibc"
DEPEND="!glibc? ( >=dev-libs/dietlibc-0.26-r1 )
		glibc? ( sys-libs/glibc )
		sys-apps/iproute2
		net-misc/vconfig
		net-firewall/iptables"

src_compile() {
	local myconf="--localstatedir=/var --with-initrddir=/etc/init.d"

	use glibc && myconf="${myconf} --disable-dietlibc"

	econf ${myconf} || die "econf failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/run/vservers.rev
	keepdir /var/run/vshelper
	keepdir /var/lock/vservers
	keepdir /vservers

	# remove the non-gentoo init-scripts:
	rm -f ${D}/etc/init.d/*

	# and install gentoo'ized ones:
	exeinto /etc/init.d/
	newexe ${FILESDIR}/${PV}/vservers.initd vservers
	newexe ${FILESDIR}/${PV}/vprocunhide vprocunhide

	# install conf.d files
	insinto /etc/conf.d
	newins ${FILESDIR}/vservers.confd vservers

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}

pkg_postinst() {
	einfo
	einfo "You have to run the vprocunhide command after every reboot"
	einfo "in order to setup /proc permissions correctly for vserver"
	einfo "use. A init script is provided by this package. To use it"
	einfo "you should add it to a runlevel:"
	einfo
	einfo " rc-update add vprocunhide default"
	einfo
}