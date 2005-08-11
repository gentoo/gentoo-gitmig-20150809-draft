# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.208-r1.ebuild,v 1.2 2005/08/11 14:03:25 r3pek Exp $

inherit eutils

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://www.nongnu.org/util-vserver/"
SRC_URI="http://www.13thfloor.at/~ensc/util-vserver/files/alpha/${P}.tar.bz2 \
	http://dev.gentoo.org/~hollow/vserver/${PN}/${P}-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="glibc crypt"
DEPEND="!glibc? ( >=dev-libs/dietlibc-0.27 )
		glibc? ( sys-libs/glibc )
		sys-apps/iproute2
		net-misc/vconfig
		crypt? ( dev-libs/beecrypt )
		net-firewall/iptables"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	epatch ${WORKDIR}/patches/*.patch
}

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
	newexe ${FILESDIR}/0.30.208-r1/vservers.initd vservers
	newexe ${FILESDIR}/vprocunhide vprocunhide

	# install conf.d files
	insinto /etc/conf.d
	newins ${FILESDIR}/0.30.208-r1/vservers.confd vservers

	# install vserver build script for gentoo guests
	dosbin ${WORKDIR}/tools/vserver-new

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}

pkg_postinst() {
	einfo
	einfo "You have to run the vprocunhide command after every reboot"
	einfo "in order to setup /proc permissions correctly for vserver"
	einfo "use. An init script is provided by this package. To use it"
	einfo "you should add it to a runlevel:"
	einfo
	einfo " rc-update add vprocunhide default"
	einfo

	ewarn "You should definitly fix up the barrier of your /vserver"
	ewarn "basedir by using the following command in a root shell: "
	ewarn
	ewarn " setattr --barrier /vservers"
	ewarn
}
