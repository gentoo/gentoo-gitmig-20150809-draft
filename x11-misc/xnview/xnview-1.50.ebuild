# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnview/xnview-1.50.ebuild,v 1.4 2003/06/18 13:22:27 phosphan Exp $

MY_P=XnView-static
S=${WORKDIR}/usr
DESCRIPTION="XnView image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ftp://www.zoo-logique.org/xnview/download/${MY_P}.i386.rpm
	ppc? ftp://www.zoo-logique.org/xnview/download/${MY_P}.ppc.rpm"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86 ~ppc"

DEPEND="app-arch/rpm2targz"

src_unpack() {
	rpm2targz ${DISTDIR}/${A}
	
	use x86 && MY_P=${MY_P}.i386
	use ppc && MY_P=${MY_P}.ppc

	tar zxvf ${WORKDIR}/${MY_P}.tar.gz &>/dev/null
}

src_install() {
	BASE_DIR=/opt/XnView

	into /opt
	dobin ${S}/X11R6/bin/{xnview,nview,nconvert}

	into ${BASE_DIR}
	dolib lib/libformat.so.3.87
	dosym ${BASE_DIR}/lib/libformat.so.3.87 ${BASE_DIR}/lib/libformat.so

	insinto /etc/env.d
	doins ${FILESDIR}/99XnView

	insinto /usr/lib/X11/app-defaults/XnView
	doins ${S}/X11R6/lib/X11/app-defaults/XnView
	fperms 444 /usr/lib/X11/app-defaults/XnView

	doman local/man/man1/*.1
	
	dodoc doc/XnView-${PV}/*.txt

	insinto ${BASE_DIR}/Filters/
	doins usr/share/XnView/Filters/*.dat
}
