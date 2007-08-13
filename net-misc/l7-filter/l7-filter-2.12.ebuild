# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-2.12.ebuild,v 1.5 2007/08/13 21:45:29 dertobi123 Exp $

inherit linux-info eutils

MY_P=netfilter-layer7-v${PV/_/-}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz
	mirror://gentoo/additional_patch_for_2.6.13.diff"

LICENSE="GPL-2"
KEYWORDS="~alpha -amd64 ~arm ~hppa -ia64 ppc -ppc64 ~s390 ~sh sparc ~x86"
IUSE=""
#break repoman
#SLOT="${KV}"
SLOT="0"
S=${WORKDIR}/${MY_P}
RDEPEND="net-misc/l7-protocols"

which_patch() {
	if kernel_is ge 2 6 22
	then
		PATCH=kernel-2.6.22-layer7-${PV}.patch
	elif kernel_is ge 2 6 20
	then
		PATCH=for_older_kernels/kernel-2.6.20-2.6.21-layer7-2.10.patch
	elif kernel_is ge 2 6 18
	then
		PATCH=for_older_kernels/kernel-2.6.18-2.6.19-layer7-2.9.patch
	elif kernel_is ge 2 6 17
	then
		PATCH=for_older_kernels/kernel-2.6.17-layer7-2.5.patch
	elif kernel_is ge 2 6 13
	then
		PATCH=for_older_kernels/kernel-2.6.13-2.6.16-layer7-2.2.patch
	elif kernel_is ge 2 6 11
	then
		PATCH=for_older_kernels/kernel-2.6.11-2.6.12-layer7-1.4.patch
	elif kernel_is ge 2 6 9
	then
		PATCH=for_older_kernels/kernel-2.6.9-2.6.10-layer7-1.2.patch
	elif kernel_is ge 2 6 0
	then
		PATCH=for_older_kernels/kernel-2.6.0-2.6.8.1-layer7-0.9.2.patch
	elif kernel_is 2 4
	then
		PATCH=kernel-2.4-layer7-${PV}.patch
	else
		die "No L7-filter patch for Kernel version ${KV_FULL} - sorry not supported"
	fi
}

pkg_setup() {
	linux-info_pkg_setup
	pkg_preinstall
	pkg_postinst
}

src_unpack() {

	which_patch

	if [ -f ${KV_DIR}/include/linux/netfilter_ipv4/ipt_layer7.h ] || \
		[ -f ${KV_DIR}/include/linux/netfilter/xt_layer7.h ]
	then
		ewarn "already installed ${PN} for kernel ${KV_FULL}"
		ewarn "If this is an upgrade attempt, try unmerging first."
		ewarn "If this failes remove your kernel source from /usr/src"
		ewarn "and remerge your kernel sources"
		die
	fi

	unpack ${MY_P}.tar.gz

	[ ! -f "${S}/${PATCH}" ] && \
		die "patch ${PATCH} not found. Please enter a bug at bugs.gentoo.org"

	cd ${S}

	mkdir  kernel
	mkdir  kernel/Documentation

	# create needed directories
	if kernel_is ge 2 6 20
	then
		mkdir -p "${S}"/kernel/net/netfilter/regexp/
		mkdir -p "${S}"/kernel/include/net/netfilter/
	else
		mkdir -p "${S}"/kernel/net/ipv4/netfilter/regexp/
		mkdir -p "${S}"/kernel/include/linux/netfilter_ipv4/
	fi

	cd ${KV_DIR}

	# start to copy needed files, if file not exists create an empty file
	FILES=$(patch -t --dry-run -p1 < "${S}"/${PATCH} | grep "^patching file" | cut -f 3 -d ' ')
	for F in ${FILES};
	do
		if [ -f "${F}" ];
		then
			cp -P "${F}" "${S}/kernel/${F}"
		#else
		#	touch "${S}/kernel/${F}"
		fi
	done

	#patch the copied kernel source
	cd ${S}/kernel
	EPATCH_OPTS="-F 3" epatch "${S}/${PATCH}"

	# https://bugs.gentoo.org/show_bug.cgi?id=106009#c5
	if kernel_is eq 2 6 12
	then
		epatch "${DISTDIR}"/additional_patch_for_2.6.13.diff
	fi
}

src_compile() {
	einfo "no compiling - just patching source"
}

src_install() {
	insinto "$(/bin/readlink -f ${KV_DIR})"
	doins -r kernel/*
	dodoc CHANGELOG README
}

pkg_preinstall() {
	if has collision-protect ${FEATURES}; then
		ewarn
		ewarn "Collisions are expected as this patches kernel code. Use"
		ewarn "FEATURES=-collision-protect emerge ...... for this package"
		die 'incompatible FEATURES=collision-protect'
	fi
}

pkg_postinst() {
	ewarn "This may not work with all kernels. If it does not work please enter a bug at bugs.gentoo.org"
	ewarn "This only patches the current kernel source code. (${KV_DIR})"
	ewarn "Its up to you to recompile the kernel with the l7 options"
	ewarn
	ewarn 'You will also need to emerge iptables with the "extensions" or'
	ewarn '"l7filter" USE flag (depend which version of iptables you emerge)'
}

#
# Unpatching of patched files is required to avoid a broken kernel source tree

pkg_prerm() {
	# How to determine what version it was installed against? - measily
	if [ -f ${ROOT}/var/db/pkg/net-misc/${PF}/environment ]; then
		eval $(/bin/fgrep KV=2 ${ROOT}/var/db/pkg/net-misc/${PF}/environment |\
			/bin/head -1)
	elif [ -f ${ROOT}/var/db/pkg/net-misc/${PF}/environment.bz2 ]; then
		eval $(/bin/bzfgrep KV=2 ${ROOT}/var/db/pkg/net-misc/${PF}/environment.bz2 |\
			/bin/head -1)
	elif [ -f ${ROOT}/var/db/pkg/net-misc/${PF}/environment.gz ]; then
		eval $(/usr/bin/zfgrep KV=2	${ROOT}/var/db/pkg/net-misc/${PF}/environment.gz |\
			/bin/head -1)
	else
		die 'could not find previous version'
	fi
	KV_DIR=/usr/src/linux-"${KV}"
	if [ -d  ${KV_DIR} ]; then
		ewarn "${KV_DIR} nolonger exists"
		return 0;
	fi
	echo "KV_DIR=$KV_DIR"
	if [ -f ${KV_DIR}/include/linux/netfilter_ipv4/ipt_layer7.h ] || \
		[ -f ${KV_DIR}/include/linux/netfilter/xt_layer7.h ]
	then
		einfo 'attempting to unpatch l7-patch from kernel ${KV_FULL}'
		which_patch
		if kernel_is eq 2 6 12
		then

				patch -F 3 -d "${KV_DIR}" -R -p1 \
					<	"${DISTDIR}"/additional_patch_for_2.6.13.diff
		fi
		cd "${T}"
		unpack ${MY_P}.tar.gz
		EPATCH_SINGLE_MSG="removing previous patch" \
			EPATCH_OPTS="-F 3 -d "${KV_DIR}" -R" epatch "${T}/${MY_P}/${PATCH}"
	fi
}
