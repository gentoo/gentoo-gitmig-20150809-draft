# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nis-utils/nis-utils-1.4.1-r1.ebuild,v 1.1 2004/06/22 03:37:34 vapier Exp $

inherit eutils

DESCRIPTION="NIS+ utilities"
HOMEPAGE="http://www.linux-nis.org/"
SRC_URI="mirror://kernel/linux/utils/net/NIS+/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls"

DEPEND="dev-libs/gmp"

src_compile() {
	econf `use_enable nls` || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install Failed"
	mv ${D}/usr/etc ${D}/
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
	exeinto /etc/init.d ; newexe ${FILESDIR}/keyserv.rc keyserv
}
