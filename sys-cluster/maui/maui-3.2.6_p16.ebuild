# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/maui/maui-3.2.6_p16.ebuild,v 1.3 2007/07/02 15:32:03 peper Exp $

inherit autotools eutils multilib

DESCRIPTION="Maui Cluster Scheduler"
HOMEPAGE="http://www.clusterresources.com/products/maui/"
SRC_URI="http://www.clusterresources.com/downloads/maui/${P/_/}.tar.gz"
IUSE=""
DEPEND="virtual/pbs"
RDEPEND="${DEPEND}
		 virtual/libc"
SLOT="0"
LICENSE="maui"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch mirror"

S="${WORKDIR}/${P/_/}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-set-pbs-cflags-ldflags.patch
	epatch "${FILESDIR}"/${PV}-autoconf-2.60-compat.patch
	epatch "${FILESDIR}"/${PV}-link-pbs-after-moab.patch
	sed -i \
		-e "s~BUILDROOT=~BUILDROOT=${D}~" \
		"${S}"/Makefile.in
	eautoreconf
}

src_compile() {
	econf \
		--with-spooldir=/usr/spool/maui \
		--with-pbs=/usr/$(get_libdir)/pbs \
		|| die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	make install INST_DIR=${D}/usr

	cd docs
	dodoc README mauidocs.html
}
