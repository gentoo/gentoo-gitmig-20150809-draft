# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia-monitor-core/ganglia-monitor-core-2.5.3.ebuild,v 1.3 2004/01/13 05:28:17 spyderous Exp $

DESCRIPTION="Ganglia is a scalable distributed monitoring system for high-performance computing systems such as clusters and Grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="net-analyzer/rrdtool"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {

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
