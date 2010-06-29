# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speakup/speakup-9999.ebuild,v 1.4 2010/06/29 14:26:42 williamh Exp $

EAPI="2"

EGIT_REPO_URI="http://linux-speakup.org/speakup.git"
inherit git linux-mod

DESCRIPTION="The speakup linux kernel based screen reader."
HOMEPAGE="http://linux-speakup.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="modules"

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

src_prepare() {
	use modules && cmd=die || cmd=ewarn
	if kernel_is lt 2 6 26; then
		$cmd "Speakup requires at least kernel version 2.6.26"
	fi
}

src_compile() {
	use modules && linux-mod_src_compile
}

src_install() {
	use modules && linux-mod_src_install
	dobin tools/speakupconf
	dosbin tools/talkwith
	dodoc Bugs.txt README To-Do doc/DefaultKeyAssignments doc/spkguide.txt
	newdoc tools/README README.tools
}

pkg_postinst() {
	use modules && linux-mod_pkg_postinst

	elog "You must set up the speech synthesizer driver to be loaded"
	elog "automatically in order for your system to start speaking"
	elog "when it is booted."
	if has_version "<sys-apps/baselayout-2"; then
		elog "this is done via /etc/modules.autoload.d/kernel-2.6"
	else
		elog "This is done via /etc/conf.d/modules."
	fi
}
