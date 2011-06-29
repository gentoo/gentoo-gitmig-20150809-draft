# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/maui/maui-3.3.1-r1.ebuild,v 1.1 2011/06/29 13:55:09 alexxy Exp $

EAPI="3"

inherit autotools eutils multilib

DESCRIPTION="Maui Cluster Scheduler"
HOMEPAGE="http://www.clusterresources.com/products/maui/"
SRC_URI="http://www.adaptivecomputing.com/download/maui/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="maui"
KEYWORDS="~amd64 ~x86 ~amd64-linux"

DEPEND="sys-cluster/torque"
RDEPEND="${DEPEND}"

RESTRICT="fetch mirror"

src_prepare() {
	epatch "${FILESDIR}"/3.2.6_p21-autoconf-2.60-compat.patch
	sed -e "s:\$(INST_DIR)/lib:\$(INST_DIR)/$(get_libdir):" \
		-i src/{moab,server,mcom}/Makefile || die
	eautoreconf
}

src_configure() {
	econf \
		--with-spooldir="${EPREFIX}"/usr/spool/maui \
		--with-pbs="${EPREFIX}"/usr
}

src_install() {
	emake install BUILDROOT="${D}" INST_DIR="${ED}/usr" || die
	dodoc docs/README CHANGELOG || die
	dohtml docs/mauidocs.html || die
	newinitd "${FILESDIR}/maui.initd" maui || die
}

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}, obtain the file"
	einfo "${P}.tar.gz and put it in ${DISTDIR}"
}
