# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/openmcl-build-tools/openmcl-build-tools-20040505.ebuild,v 1.1 2005/03/11 16:51:04 mkennedy Exp $

inherit eutils common-lisp-common-2

DEB_PV=2

DESCRIPTION="OpenMCL is a Common Lisp implementation, derived from Digitool's MCL  product"
HOMEPAGE="http://packages.debian.org/unstable/devel/openmcl-build-tools"
SRC_URI="http://ftp.debian.org/debian/pool/main/o/${PN}/${PN}_${PV}-${DEB_PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	tar xfz ${S}/openmcl-interfaces-${PV:2}.tar.gz -C ${S} || die
}

src_install() {
	insinto /usr/lib/openmcl
	doins PPCCL-orig
	doins -r ccl/headers
	do-debian-credits
}
