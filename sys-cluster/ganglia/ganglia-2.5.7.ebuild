# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia/ganglia-2.5.7.ebuild,v 1.1 2005/07/28 23:20:38 tantive Exp $

MY_P=ganglia-monitor-core-${PV}
DESCRIPTION="Ganglia is a scalable distributed monitoring system for high-performance computing systems such as clusters and Grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${MY_P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="net-analyzer/rrdtool"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	cd ${S}
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-gexec \
		--with-gmetad || die "./configure failed"

	emake || die
}

src_install() {

	einstall || die

	insinto /etc
	doins gmond/gmond.conf
	doins gmetad/gmetad.conf
	doman mans/{gmetad.1,gmetric.1,gmond.1,gstat.1}
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	dodir /var/lib/ganglia/rrds
	fowners nobody:nobody /var/lib/ganglia/rrds
	exeinto /etc/init.d
	newexe ${FILESDIR}/gmond.rc gmond
	newexe ${FILESDIR}/gmetad.rc gmetad

}
