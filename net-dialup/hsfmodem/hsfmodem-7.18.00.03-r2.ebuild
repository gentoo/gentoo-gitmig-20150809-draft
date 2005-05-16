# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsfmodem/hsfmodem-7.18.00.03-r2.ebuild,v 1.2 2005/05/16 13:14:05 seemant Exp $

inherit eutils

DESCRIPTION="Linuxant's modem driver for Conexant HSF chipset"
HOMEPAGE="http://www.linuxant.com/drivers/hsf/index.php"
SRC_URI="x86? ( http://www.linuxant.com/drivers/hsf/full/archive/${P}full/${P}full.tar.gz )
	amd64? ( http://www.linuxant.com/drivers/hsf/full/archive/${P}x86_64full/${P}x86_64full.tar.gz )"

LICENSE="Conexant"
KEYWORDS="-* x86 ~amd64"
IUSE=""
SLOT="0"

DEPEND="virtual/libc
	dev-lang/perl
	app-arch/cpio"

S="${WORKDIR}"

pkg_setup() {
	if useq x86; then
		MY_ARCH_S=${S}/${P}full
	elif useq amd64; then
		MY_ARCH_S=${S}/${P}x86_64full
	fi
}

src_unpack() {
	unpack ${A}

	cd $MY_ARCH_S
	epatch ${FILESDIR}/${P}-nvminstall.patch
}

src_compile() {
	cd ${MY_ARCH_S}
	emake all || die "make failed"
}

src_install () {
	cd ${MY_ARCH_S}
	make PREFIX=${D}/usr/ ROOT=${D} install || die "make install failed"
}

pkg_preinst() {
	local NVMDIR=/etc/${PN}/nvm
	if [ -d "${NVMDIR}" ]; then
		einfo "Cleaning ${NVMDIR}..."
		rm -rf /etc/${NVMDIR}
		eend
	fi
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HSF modem,"
	einfo "please run hsfconfig."
}
