# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.11-r1.ebuild,v 1.13 2004/04/05 02:30:51 agriffis Exp $

IUSE="nls"

MY_P=${PN}-mt-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Multithreaded NIS bind service"
SRC_URI="mirror://kernel/linux/utils/net/NIS/OLD/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linux-nis.org/nis/ypbind-mt/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ia64"

DEPEND="net-nds/yp-tools
	net-nds/portmap"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf} || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README THANKS TODO
	insinto /etc ; doins etc/yp.conf
	insinto /etc/conf.d ; newins ${FILESDIR}/ypbind.confd ypbind
	exeinto /etc/init.d ; newexe ${FILESDIR}/ypbind.rc6 ypbind
}
