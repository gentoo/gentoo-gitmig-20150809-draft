# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ventrilo-server-bin/ventrilo-server-bin-2.1.2.ebuild,v 1.6 2004/07/21 08:57:08 eradicator Exp $

IUSE=""
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
