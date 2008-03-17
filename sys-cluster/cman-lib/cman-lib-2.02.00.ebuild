# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman-lib/cman-lib-2.02.00.ebuild,v 1.1 2008/03/17 16:24:34 xmerlin Exp $

inherit eutils versionator

CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="A library for cluster management common to the various pieces of Cluster Suite."
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!sys-cluster/cman-headers
	!sys-cluster/cman-kernel
	!=sys-cluster/cman-1*
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${PN/-//}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-include.patch || die
}

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--release_major="$MAJ_PV" \
			--release_minor="$MIN_PV" \
	) || die "configure problem"

	emake clean || die "clean problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "install problem"
}
