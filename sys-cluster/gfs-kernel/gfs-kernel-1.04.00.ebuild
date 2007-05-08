# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs-kernel/gfs-kernel-1.04.00.ebuild,v 1.1 2007/05/08 10:53:48 xmerlin Exp $

inherit eutils linux-mod linux-info

CLUSTER_RELEASE="1.04.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="GFS kernel module"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND=">=virtual/linux-sources-2.6.17
	=sys-cluster/dlm-headers-${CLUSTER_RELEASE}*
	=sys-cluster/cman-headers-${CLUSTER_RELEASE}*"

RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

pkg_setup() {
	linux-mod_pkg_setup
	case ${KV_FULL} in
		2.2.*|2.4.*) die "${P} supports only 2.6 kernels";;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if kernel_is 2 6; then
		#if [ "$KV_PATCH" -lt "17" ] ; then
		#	epatch ${FILESDIR}/gfs-kernel-1.04.00-pre2.6.17-compilefix.patch || die
		#fi
		if [ "$KV_PATCH" -lt "18" ] ; then
			sed -i \
				-e 's|utsrelease.h|version.h|g' \
				configure \
				|| die "sed failed"

			sed -i \
				-e 's|init_utsname()->nodename|system_utsname.nodename|g' \
				src/gulm/gulm_fs.c \
				|| die "sed failed"
		fi
	fi
}

src_compile() {
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} --verbose || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} module_dir=${D}/lib/modules/${KV_FULL} install || die "install problem"
	rm -f ${D}/usr/include/linux/* || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge ${PN} when you upgrade your kernel!"
	einfo ""
}
