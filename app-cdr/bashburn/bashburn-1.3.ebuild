# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bashburn/bashburn-1.3.ebuild,v 1.1 2004/01/12 21:04:26 rphillips Exp $

P=${P/bashburn/BashBurn}
S=${WORKDIR}/BashBurn
DESCRIPTION="cd burning shell script"
HOMEPAGE="http://bashburn.sourceforge.net"
SRC_URI="mirror://sourceforge/bashburn/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
DEPEND=""
SLOT="0"

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
	doexe BashBurn.sh
	cp bashburnrc ${D}/etc/bashburn
	ln -sf /opt/BashBurn/BashBurn.sh ${D}/usr/bin/bashburn

	dodoc README HOWTO
}
