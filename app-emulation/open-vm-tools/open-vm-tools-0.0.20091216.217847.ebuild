# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/open-vm-tools/open-vm-tools-0.0.20091216.217847.ebuild,v 1.1 2009/12/20 14:05:42 vadimk Exp $

EAPI="2"

inherit eutils pam versionator

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
IUSE="X doc fuse icu +pic unity xinerama"

RDEPEND="app-emulation/open-vm-tools-kmod
	>=dev-libs/glib-2
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
		x11-libs/libXtst
	)
	fuse? ( sys-fs/fuse )
	icu? ( dev-libs/icu )
	unity? (
		dev-libs/uriparser
		x11-libs/libXScrnSaver
	)
	xinerama? ( x11-libs/libXinerama )
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	virtual/linux-sources
	doc? ( app-doc/doxygen )
	"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use unity && ! use xinerama && die 'The Unity USE flag requires USE="xinerama" as well'

	enewgroup vmware
}

src_prepare() {
	epatch "${FILESDIR}/default-scripts1.patch"
	epatch "${FILESDIR}/checkvm-pie-safety.patch"
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
		$(use_with pic) \
		$(use_enable unity) \
		$(use_enable xinerama multimon)
}

src_compile() {
	emake || die "failed to compile"
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"

	rm "${D}"/etc/pam.d/vmtoolsd
	pamd_mimic_system vmtoolsd auth account

	rm "${D}"/usr/$(get_libdir)/*.la
	rm "${D}"/usr/$(get_libdir)/open-vm-tools/plugins/common/*.la

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
