# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bashburn/bashburn-1.3.ebuild,v 1.6 2004/10/05 11:22:55 pvdabeel Exp $


MY_P=${P//b/B}
S=${WORKDIR}/${PN//b/B}
DESCRIPTION="cd burning shell script"
HOMEPAGE="http://bashburn.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="app-shells/bash"

src_compile() {
	echo "Skipping Compile"
}

src_install() {
	sed -i "s:export CONFFILE=/etc/bashburnrc:export CONFFILE=/etc/bashburn/bashburnrc:g" BashBurn.sh
	sed -i "s:ROOTDIR\:.*:ROOTDIR\: /opt/BashBurn:g" bashburnrc

	dodir /etc/bashburn
	dodir /opt/BashBurn
	dodir /usr/bin

	mv {burning,config,convert,menus,misc} ${D}/opt/BashBurn

	exeinto /opt/BashBurn
	doexe BashBurn.sh || die
	cp bashburnrc ${D}/etc/bashburn
	ln -sf /opt/BashBurn/BashBurn.sh ${D}/usr/bin/bashburn

	dodoc README HOWTO
}
