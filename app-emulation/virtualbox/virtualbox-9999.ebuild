# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox/virtualbox-9999.ebuild,v 1.4 2007/02/12 18:55:09 jokey Exp $

inherit eutils linux-mod qt3 subversion

DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
ESVN_REPO_URI="http://virtualbox.org/svn/vbox/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	dev-libs/xalan-c
	dev-libs/xerces-c
	media-libs/libsdl
	x11-libs/libXcursor
	$(qt_min_version 3.3.5)"
DEPEND="${REPEND}
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl"

BUILD_TARGETS="all"
BUILD_PARAMS="KERN_DIR=${KERNEL_DIR}"
MODULE_NAMES="vboxdrv(misc:${S}/out/linux.${ARCH}/release/bin/src:${S}/out/linux.${ARCH}/release/bin/src)"

src_compile() {
	cd "${S}"
	./configure || die "configure failed"
	source ./env.sh
	kmk all
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	cd "${S}"/out/linux.${ARCH}/release/bin
	rm -rf sdk src tst* testcase additions/src
	rm vboxdrv.ko SUPInstall SUPUninstall
	insinto /opt/VirtualBox
	doins -r *
	for each in VBox{BFE,Manage,SDL,SVC,XPCOMIPCD} VirtualBox vditool xpidl additions/vboxadd-timesync ; do
		fperms 0755 /opt/VirtualBox/${each}
	done
	make_wrapper vboxsvc "./VBoxSVC" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	make_wrapper virtualbox "./VirtualBox" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
}
