# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The Ventrilo Voice Communication Server"
HOMEPAGE="http://www.ventrilo.com/"
SRC_URI="ventrilo_srv-2.1.2-Linux-i386.tar.gz"

LICENSE="ventrilo"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://www.ventrilo.com/download.php"
	einfo "and download the Linux i386 - 32bit ${PV} server."
	einfo "Just save it in ${DISTDIR} !"
}

src_install() {
	exeinto /opt/ventrilo-server
	doexe ventrilo_{srv,status}

	insinto /opt/ventrilo-server
	doins ventrilo_srv.{ini,usr}

	dohtml ventrilo_srv.htm
}
