# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.204.ebuild,v 1.1 2005/02/23 15:26:43 hollow Exp $

inherit eutils

DESCRIPTION="vserver admin utilities (alpha version)"
SRC_URI="http://www-user.tu-chemnitz.de/~ensc/util-vserver/alpha/${P}.tar.bz2"
HOMEPAGE="http://www-user.tu-chemnitz.de/~ensc/util-vserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-libs/dietlibc-0.26-r1
	sys-apps/iproute2
	net-misc/vconfig"

src_compile() {
	local myconf="--localstatedir=/var --with-initrddir=/etc/init.d"

	econf ${myconf} || die "econf failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	# keep state dir
	keepdir /var/run/vservers

	# keep & secure /vservers
	keepdir /vservers
	fperms 000 /vservers

	# remove the non-gentoo init-scripts:
	rm -f ${D}/etc/init.d/*

	# and install gentoo'ized ones:
	exeinto /etc/init.d/
	newexe ${FILESDIR}/${PV}/vservers.initd vservers

	# install conf.d files
	insinto /etc/conf.d
	newins ${FILESDIR}/${PV}/vservers.confd vservers

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}

pkg_postinst() {
	einfo
	einfo "To make use of the tools in this package"
	einfo "you need to run a vserver-enabled kernel"
	einfo
}
