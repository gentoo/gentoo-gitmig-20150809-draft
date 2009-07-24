# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/open-vm-tools/open-vm-tools-0.0.20090722.179896.ebuild,v 1.1 2009/07/24 23:12:56 vadimk Exp $

EAPI="2"

inherit eutils linux-mod pam versionator

MY_DATE="$(get_version_component_range 3)"
MY_BUILD="$(get_version_component_range 4)"
MY_PV="${MY_DATE:0:4}.${MY_DATE:4:2}.${MY_DATE:6:2}-${MY_BUILD}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Opensourced tools for VMware guests"
HOMEPAGE="http://open-vm-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc fuse icu unity xinerama"

RDEPEND=">=dev-libs/glib-2
		dev-libs/libdnet
		sys-apps/ethtool
		sys-process/procps
		virtual/pam
		X? (
			dev-cpp/gtkmm
			x11-base/xorg-server
			x11-drivers/xf86-input-vmmouse
			x11-drivers/xf86-video-vmware
			x11-libs/gtk+
			x11-libs/libnotify
			x11-libs/libX11
		)
		fuse? ( sys-fs/fuse )
		icu? ( dev-libs/icu )
		unity? (
			dev-libs/uriparser
			x11-libs/libXScrnSaver
		)
		xinerama? ( x11-libs/libXinerama )
		!app-emulation/vmware-esx-tools
		!app-emulation/vmware-server-tools
		!app-emulation/vmware-workstation-tools
		"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		virtual/linux-sources
		doc? ( app-doc/doxygen )
		"

S="${WORKDIR}/${MY_P}"

VMWARE_MOD_DIR="modules/linux"
VMWARE_MODULE_LIST="pvscsi vmblock vmci vmhgfs vmsync vmmemctl vmxnet vmxnet3 vsock"

pkg_setup() {
	use unity && ! use xinerama && \
	  die 'The Unity USE flag requires USE="xinerama" as well'

	linux-mod_pkg_setup
	MODULE_NAMES=""
	BUILD_TARGETS="auto-build HEADER_DIR=${KERNEL_DIR}/include BUILD_DIR=${KV_OUT_DIR} OVT_SOURCE_DIR=${S}"

	for mod in ${VMWARE_MODULE_LIST};
	do
		if [ "${mod}" == "vmxnet" -o "${mod}" == "vmxnet3" ];
		then
			MODTARGET="net"
		else
			MODTARGET="openvmtools"
		fi
		MODULE_NAMES="${MODULE_NAMES} ${mod}(${MODTARGET}:${S}/${VMWARE_MOD_DIR}/${mod})"
	done

	enewgroup vmware
}

src_prepare() {
	epatch "${FILESDIR}/default-scripts.patch"
	#sed -i -e 's:VMTOOLSD_PLUGIN_ROOT=\\"\$(pkglibdir)\\":VMTOOLSD_PLUGIN_ROOT=\\"\$(pkglibdir)/plugins\\":g' \
	#	services/vmtoolsd/Makefile.in || die "sed plugin path failed"
	sed -i -e 's/proc-3.2.7/proc/g' configure || die "sed configure failed"
	sed -i -e 's/CFLAGS=.*Werror/#&/g' configure || die "sed comment out Werror failed"
}

src_configure() {
	econf \
		--with-procps \
		--with-dnet \
		--without-kernel-modules \
		$(use_with X x) \
		$(use_with X gtk2) \
		$(use_with X gtkmm) \
		$(use_with icu) \
		$(use_enable unity) \
		$(use_enable xinerama multimon)
}

src_compile() {
	linux-mod_src_compile

	emake || die "failed to compile"
}

src_install() {
	linux-mod_src_install

	emake DESTDIR="${D}" install || die "failed to install"

	rm "${D}"/etc/pam.d/vmtoolsd
	pamd_mimic_system vmtoolsd auth account

	newinitd "${FILESDIR}/open-vm-tools.initd" vmware-tools || die "failed to newinitd"
	newconfd "${FILESDIR}/open-vm.confd" vmware-tools || die "failed to newconfd"

	if use X;
	then
		insinto /etc/xdg/autostart
		doins "${FILESDIR}/open-vm-tools.desktop" || die "failed to install .desktop"

		elog "To be able to use the drag'n'drop feature of VMware for file"
		elog "exchange, you need to do this:"
		elog "	Add 'vmware-tools' to your default runlevel."
		elog "	Add the users which should have access to this function"
		elog "	to the group 'vmware'."
	fi
}
