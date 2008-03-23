# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd/gnbd-2.02.00-r1.ebuild,v 1.1 2008/03/23 16:39:50 xmerlin Exp $

inherit eutils versionator

CVS_RELEASE="20080323"
CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="GFS Network Block Devices"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/gfs-${PV}-${CVS_RELEASE}-cvs.patch.bz2
	http://dev.gentoo.org/~xmerlin/gfs/gfs-${PV}-${CVS_RELEASE}-cvs.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=sys-cluster/cman-lib-${CLUSTER_RELEASE}*"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	(cd "${WORKDIR}"/${MY_P};
		epatch "${WORKDIR}"/gfs-2.02.00-20080323-cvs.patch || die
	)
}

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--somajor="$MAJ_PV" \
			--sominor="$MIN_PV" \
			--dlmlibdir=/usr/lib \
			--dlmincdir=/usr/include \
			--cmanlibdir=/usr/lib \
			--cmanincdir=/usr/include \
	) || die "configure problem"

	# fix the manual pages have executable bit
	sed -i -e '
		/\tinstall -d/s/install/& -m 0755/; t
		/\tinstall/s/install/& -m 0644/' \
		man/Makefile

	emake clean all || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "install problem"

	newinitd "${FILESDIR}"/${PN}-client-2.0x.rc ${PN}-client || die
	newinitd "${FILESDIR}"/${PN}-srv-2.0x.rc ${PN}-srv || die

	doconfd "${FILESDIR}"/${PN}-client-2.0x.conf || die
	doconfd "${FILESDIR}"/${PN}-srv-2.0x.conf || die

	insinto /etc
	doins "${FILESDIR}"/gnbdtab

	if $(has_version sys-fs/devfsd ) ; then
		insinto /etc/devfs.d/
		newins "${FILESDIR}"/gnbd.devfs gnbd
	fi
}
