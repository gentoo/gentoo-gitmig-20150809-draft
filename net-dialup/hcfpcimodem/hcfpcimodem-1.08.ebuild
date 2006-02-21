# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfpcimodem/hcfpcimodem-1.08.ebuild,v 1.2 2006/02/21 23:11:39 mrness Exp $

inherit eutils

#The document is the same as in hsfmodem, even if it has a different URL
MY_DOC="100498D_RM_HxF_Released.pdf"

DESCRIPTION="Linuxant's modem driver for Connexant HCF chipset"
HOMEPAGE="http://www.linuxant.com/drivers/hcf/index.php"
SRC_URI="http://www.linuxant.com/drivers/hcf/full/archive/${P}full/${P}full.tar.gz
	doc? ( http://www.linuxant.com/drivers/hcf/full/archive/${P}full/${MY_DOC} )"

LICENSE="Conexant"
SLOT="0"
KEYWORDS="-* x86"
IUSE="doc"

DEPEND="virtual/libc
	dev-lang/perl
	app-arch/cpio"

S=${WORKDIR}/${P}full

pkg_setup () {
	MOD_N="hcfpci"
	# Check to see if module is inserted into kernel, otherwise, build fails
	if [ "`lsmod | sed '/^'$MOD_N'serial/!d'`" ]; then
		eerror
		eerror "Module is in use by the kernel!!!"
		eerror "Attempting to unload..."
		eerror

		# Unloading module...
		${MOD_N}stop
		if [ "`lsmod | sed '/^'$MOD_N'serial/!d'`" ]; then
			eerror "Failed to unload modules from kernel!!!"
			eerror "Please manualy remove the module from the kernel and emerge again."
			eerror
			die
		fi
		einfo "Successfuly removed module from memory.  Resuming emerge."
		einfo
	fi
}

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-upstream-20051215.patch
}

src_compile() {
	emake all || die
}

pkg_preinst() {
	local NVMDIR=/etc/${PN}/nvm
	if [ -d "${NVMDIR}" ]; then
		einfo "Cleaning ${NVMDIR}..."
		rm -rf /etc/${NVMDIR}
		eend
	fi
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die

	use doc && dodoc "${DISTDIR}/${MY_DOC}"
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HCF modem,"
	einfo "please run hcfpciconfig."
}

