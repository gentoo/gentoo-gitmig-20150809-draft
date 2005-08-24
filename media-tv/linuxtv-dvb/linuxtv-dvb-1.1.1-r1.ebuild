# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb/linuxtv-dvb-1.1.1-r1.ebuild,v 1.7 2005/08/24 20:05:41 agriffis Exp $

inherit eutils kernel-mod

DVB_TTPCI_FW="dvb-ttpci-01.fw-261c"
DESCRIPTION="Standalone DVB driver for Linux kernel 2.4.x"
HOMEPAGE="http://www.linuxtv.org"
SRC_URI="http://www.linuxtv.org/download/dvb/${P}.tar.bz2
		http://www.linuxtv.org/download/dvb/firmware/${DVB_TTPCI_FW}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~x86"
IUSE=""
DEPEND="virtual/linux-sources"
#RDEPEND=""

pkg_setup() {
	if kernel-mod_is_2_4_kernel; then
		einfo
		einfo "Please make sure that the following option is enabled"
		einfo "in your current kernel 'Multimedia devices'"
		einfo "and /usr/src/linux point's to your current kernel"
		einfo "or make will die."
		einfo
	fi
}

src_compile() {
	# Nothing to compile if running on a kernel 2.6 system
	# modules in kernel are newer!
	if kernel-mod_is_2_4_kernel; then
		# don't interfere with the kernel arch variables
		unset ARCH
		emake || die "emake failed"
	else
		einfo "Nothing to compile."
	fi
}

src_install() {
	# see what kernel directory we need to
	# go to
	if kernel-mod_is_2_4_kernel; then
		cd ${S}/build-2.4
		KV_OBJ="o"
	else
		KV_OBJ="ko"
	fi

	if kernel-mod_is_2_4_kernel; then
		#copy over the insmod.sh script
		#for loading all modules
		sed -e "s:insmod ./:modprobe :" -i insmod.sh
		sed -e "s:.${KV_OBJ}::" -i insmod.sh
		newsbin insmod.sh dvb-module-load
	else
		# copy kernel 2.6 insmod.sh script
		sed -e "s:insmod ./:modprobe :" -i build-2.6/insmod.sh
		sed -e "s:.${KV_OBJ}::" -i build-2.6/insmod.sh
		newsbin build-2.6/insmod.sh dvb-module-load
	fi

	if kernel-mod_is_2_4_kernel; then
		# install the modules
		insinto /lib/modules/${KV}/misc
		doins *.${KV_OBJ}

		# install the header files
		# linux26-headers installs those
		# FIXME: is it save to assume _all_ kernel 2.6 users got that?
		cd ${S}/linux/include/linux/dvb
		insinto /usr/include/linux/dvb
		doins *.h
	fi

	#install the main docs
	cd ${S}
	dodoc MAKEDEV-DVB.sh NEWS README README.bt8xx TODO TROUBLESHOOTING

	#install the other docs
	cd ${S}/doc
	dodoc HOWTO-use-the-demux-api \
	README.valgrind HOWTO-use-the-frontend-api \
	convert.sh valgrind-2.1.0-dvb.patch

	# install dvb-ttpci firmware
	if has_version '>=sys-apps/hotplug-20040920'; then
		insinto /lib/firmware
	else
		insinto /usr/lib/hotplug/firmware
	fi
	donewins ${DISTDIR}/${DVB_TTPCI_FW} dvb-ttpci-01.fw
}

pkg_postinst() {
	einfo "If you don't use devfs, execute MAKEDEV-DVB.sh to create"
	einfo "the device nodes. The file is in /usr/share/doc/${PF}/"
	einfo
	einfo "A file called dvb-module-load has been created to simplify loading all modules."
	einfo "Call it using 'dvb-module-load {load|debug|unload}'."
	einfo
	einfo "For information about firmware please see /usr/share/doc/${PF}/README."
	einfo

	if kernel-mod_is_2_4_kernel; then
		einfo "Checking kernel module dependencies"
		test -r "${ROOT}/usr/src/linux/System.map" && \
			depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
	else
	        einfo
			einfo "Modules for kernel 2.6 will not be built."
			einfo "According to the README-2.6 the driver in kernel"
			einfo "2.6.1 and above is regularily kept up-to-date."
			einfo "Therefore it is very likely that your kernel"
			einfo "has newer modules then the latest release."
			einfo "This ebuild will just install the dvb-ttpci"
			einfo "firmware and docs on kernel 2.6 machines."
			einfo
	fi
}
