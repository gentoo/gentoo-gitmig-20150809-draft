# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-2.03.09.ebuild,v 1.2 2008/11/21 22:59:59 xmerlin Exp $

inherit eutils versionator

CVS_RELEASE="20080323"
CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/wiki"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

#RDEPEND="=sys-cluster/gfs2-${CLUSTER_RELEASE}*"
RDEPEND="=sys-cluster/ccs-${CLUSTER_RELEASE}*
	=sys-cluster/cman-${CLUSTER_RELEASE}*
	=sys-cluster/fence-${CLUSTER_RELEASE}*
	sys-fs/e2fsprogs"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

}

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--somajor="$MAJ_PV" \
			--sominor="$MIN_PV" \
	) || die "configure problem"

	# gfs now depeneds on gfs2, due to common mount command.
	# to avoid a dependency on gfs2, we simply build its mount command twice
	# and rename it
	sed -i \
		-e '/ln -sf [u]\?mount.gfs2 [u]\?mount.gfs/d' \
		Makefile

	(cd "${WORKDIR}"/${MY_P}/gfs2/mount;
		emake -j1 \
	) || die "compile problem"

	# fix -ggdb CFLAGS
	#sed -i \
	#	-e '/-ggdb/d' \
	#	libgfs/Makefile

	# fix the manual pages have executable bit
	sed -i -e '
		/\tinstall -d/s/install/& -m 0755/; t
		/\tinstall/s/install/& -m 0644/' \
		man/Makefile

	emake -j1 clean all || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "install problem"

	mv "${WORKDIR}"/${MY_P}/gfs2/mount/mount.gfs2 "${D}"/sbin/mount.gfs
	mv "${WORKDIR}"/${MY_P}/gfs2/mount/umount.gfs2 "${D}"/sbin/umount.gfs

	keepdir /etc/cluster || die
	newinitd "${FILESDIR}"/${PN}-2.0x.rc ${PN} || die

	if use doc ; then
		dodoc "${WORKDIR}"/${MY_P}/doc/*.txt || die
	fi
}
