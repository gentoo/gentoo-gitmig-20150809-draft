# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speakup/speakup-3.0.2_p20080414.ebuild,v 1.1 2008/04/19 21:20:18 williamh Exp $

inherit linux-mod

DESCRIPTION="The speakup linux kernel based screen reader."
HOMEPAGE="http://linux-speakup.org"
SRC_URI="http://dev.gentoo.org/~williamh/dist/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${PN}-3.0.2"

pkg_setup() {
	linux-mod_pkg_setup
	case ${KV_FULL} in
		2.6.25-gentoo*) ;;
		*)	die "Speakup requires gentoo-sources-2.6.25-*"
			;;
	esac

	MODULE_NAMES="speakup(${PN}:\"${S}\"/src)
		speakup_acntpc(${PN}:\"${S}\"/src)
		speakup_acntsa(${PN}:\"${S}\"/src)
		speakup_apollo(${PN}:\"${S}\"/src)
		speakup_audptr(${PN}:\"${S}\"/src)
		speakup_bns(${PN}:\"${S}\"/src)
		speakup_decext(${PN}:\"${S}\"/src)
		speakup_decpc(${PN}:\"${S}\"/src)
		speakup_dectlk(${PN}:\"${S}\"/src)
		speakup_dtlk(${PN}:\"${S}\"/src)
		speakup_dummy(${PN}:\"${S}\"/src)
		speakup_keypc(${PN}:\"${S}\"/src)
		speakup_ltlk(${PN}:\"${S}\"/src)
		speakup_soft(${PN}:\"${S}\"/src)
		speakup_spkout(${PN}:\"${S}\"/src)
		speakup_txprt(${PN}:\"${S}\"/src)"
	BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
	BUILD_TARGETS="clean all"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "You must set up the speech synthesizer driver to be loaded"
	elog "automatically in order for your system to start speaking"
	elog "when it is booted."
	if has_version "<sys-apps/baselayout-2"; then
		elog "this is done via /etc/modules.autoload.d/kernel-2.6"
	else
		elog "This is done via /etc/conf.d/modules."
	fi
}
