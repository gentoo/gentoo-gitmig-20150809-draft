# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.12.ebuild,v 1.7 2004/08/24 23:23:27 eradicator Exp $

IUSE="nls slp"

MY_P=${PN}-mt-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Multithreaded NIS bind service (ypbind-mt)"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linux-nis.org/nis/ypbind-mt/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ppc64"

DEPEND="net-nds/yp-tools
	slp? ( net-libs/openslp )
	net-nds/portmap"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` `use_enable slp` || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README THANKS TODO
	insinto /etc ; doins etc/yp.conf
	insinto /etc/conf.d ; newins ${FILESDIR}/ypbind.confd ypbind
	exeinto /etc/init.d ; newexe ${FILESDIR}/ypbind.rc6 ypbind
}

pkg_postinst() {
	einfo "To complete setup, you will need to edit /etc/conf.d/ypbind."
}
