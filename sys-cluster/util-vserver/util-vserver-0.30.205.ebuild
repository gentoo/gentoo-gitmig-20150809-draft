# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.205.ebuild,v 1.1 2005/03/30 11:43:40 hollow Exp $

inherit eutils

DESCRIPTION="vserver admin utilities (alpha version)"
SRC_URI="http://www.13thfloor.at/~ensc/util-vserver/files/alpha/${P}.tar.bz2"
HOMEPAGE="http://www-user.tu-chemnitz.de/~ensc/util-vserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-libs/dietlibc-0.26-r1
	sys-apps/iproute2
	net-misc/vconfig
	net-firewall/iptables"

src_compile() {
	local myconf="--localstatedir=/var --with-initrddir=/etc/init.d"

	econf ${myconf} || die "econf failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/lock/vservers
	keepdir /var/run/vshelper
	keepdir /vservers
	fperms 000 /vservers

	# remove the non-gentoo init-scripts:
	rm -f ${D}/etc/init.d/*

	# and install gentoo'ized ones:
	exeinto /etc/init.d/
	newexe ${FILESDIR}/vservers.initd vservers

	# install conf.d files
	insinto /etc/conf.d
	newins ${FILESDIR}/vservers.confd vservers

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}
