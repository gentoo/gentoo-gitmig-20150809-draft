# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-modules/vmware-modules-1.0.0.25-r4.ebuild,v 1.2 2011/03/18 15:53:13 mr_bones_ Exp $

EAPI="2"

inherit eutils flag-o-matic linux-info linux-mod

DESCRIPTION="VMware kernel modules"
HOMEPAGE="http://www.vmware.com/"

SRC_URI="x86? (
		mirror://gentoo/${P}.x86.tar.bz2
		http://dev.gentoo.org/~vadimk/${P}.x86.tar.bz2
	)
	amd64? (
	 	mirror://gentoo/${P}.amd64.tar.bz2
		http://dev.gentoo.org/~vadimk/${P}.amd64.tar.bz2
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	if kernel_is ge 2 6 37; then
		CONFIG_CHECK="BKL"
		linux-info_pkg_setup
	fi

	linux-mod_pkg_setup

	VMWARE_VER="VME_V65" # THIS VALUE IS JUST A PLACE HOLDER
	VMWARE_GROUP=${VMWARE_GROUP:-vmware}

	VMWARE_MODULE_LIST="vmblock vmci vmmon vmnet vsock"
	VMWARE_MOD_DIR="${PN}-${PVR}"

	BUILD_TARGETS="auto-build VMWARE_VER=${VMWARE_VER} KERNEL_DIR=${KERNEL_DIR} KBUILD_OUTPUT=${KV_OUT_DIR}"

	enewgroup "${VMWARE_GROUP}"
	filter-flags -mfpmath=sse

	for mod in ${VMWARE_MODULE_LIST}; do
		MODULE_NAMES="${MODULE_NAMES} ${mod}(misc:${S}/${mod}-only)"
	done
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	for mod in ${VMWARE_MODULE_LIST}; do
		unpack ./"${P}"/${mod}.tar
	done
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-makefile-kernel-dir.patch"
	epatch "${FILESDIR}/${PV}-makefile-include.patch"
	epatch "${FILESDIR}/sched_h-2.6.32.patch"
	epatch "${FILESDIR}/${PV}-autoconf-generated.patch"
	epatch "${FILESDIR}/apic.patch"
	kernel_is ge 2 6 35 && epatch "${FILESDIR}/${PV}-sk_sleep.patch"
	kernel_is ge 2 6 36 && epatch "${FILESDIR}/${PV}-unlocked_ioctl.patch"
	kernel_is ge 2 6 37 && epatch "${FILESDIR}/${PV}-sema.patch"

	sed -i.bak -e '/\smake\s/s/make/$(MAKE)/g' {vmmon,vsock,vmblock,vmnet,vmci}-only/Makefile\
		|| die "Sed failed."
}

src_install() {
	linux-mod_src_install
	local udevrules="${T}/60-vmware.rules"
	cat > "${udevrules}" <<-EOF
		KERNEL=="vmci",  GROUP="vmware", MODE=660
		KERNEL=="vmmon", GROUP="vmware", MODE=660
		KERNEL=="vsock", GROUP="vmware", MODE=660
	EOF
	insinto /etc/udev/rules.d/
	doins "${udevrules}"
}
