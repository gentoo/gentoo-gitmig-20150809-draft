# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.ebuild,v 1.2 2005/01/23 08:49:41 hollow Exp $

inherit eutils

DESCRIPTION="Vserver admin-tools."
SRC_URI="http://www-user.tu-chemnitz.de/~ensc/util-vserver/${P}.tar.bz2"
HOMEPAGE="http://savannah.nongnu.org/projects/util-vserver/ http://www-user.tu-chemnitz.de/~ensc/util-vserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND=">=dev-libs/dietlibc-0.24"

src_compile() {
	econf || die "econf failed"
	make || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	## state-dir:
	keepdir /var/run/vservers
	## the actual vservers go there:
	keepdir /vservers
	fperms 000 /vservers

	## sample config and script:
	insinto /etc/vservers
	doins distrib/sample.conf distrib/sample.sh

	## remove the non-gentoo init-scripts:
	rm -f ${D}/etc/init.d/*
	## ... and install gentoo'ized ones:
	exeinto /etc/init.d/
	newexe ${FILESDIR}/vservers.initd vservers
	newexe ${FILESDIR}/rebootmgr.initd rebootmgr

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}

pkg_postinst() {
	einfo "To make use of the tools in this package you need to run a \"sys-kernel/vserver-sources\"-kernel."
}
