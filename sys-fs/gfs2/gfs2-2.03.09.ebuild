# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs2/gfs2-2.03.09.ebuild,v 1.4 2009/01/15 17:25:40 jer Exp $

inherit eutils versionator

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

	# fix symlinks error
	#sed -i \
	#	-e '\@\tln -sf ${sbindir}/${TARGET1}@s@${sbindir}/@@' \
	#	mkfs/Makefile fsck/Makefile

	# fix -ggdb CFLAGS
	#sed -i \
	#	-e '/-ggdb/d' \
	#	edit/Makefile mkfs/Makefile libgfs2/Makefile

	# fix the manual pages have executable bit
	sed -i -e '
		/\tinstall -d/s/install/& -m 0755/; t
		/\tinstall/s/install/& -m 0644/' \
		man/Makefile

	emake -j1 clean all || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "install problem"

	keepdir /etc/cluster || die
	newinitd "${FILESDIR}"/${PN}.rc ${PN} || die

	if use doc ; then
		dodoc "${WORKDIR}"/${MY_P}/doc/*.txt || die
	fi
}
