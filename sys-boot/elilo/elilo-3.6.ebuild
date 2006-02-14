# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/elilo/elilo-3.6.ebuild,v 1.2 2006/02/14 21:50:13 agriffis Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Linux boot loader for EFI-based systems such as IA-64"
HOMEPAGE="http://elilo.sourceforge.net/"
SRC_URI="mirror://sourceforge/elilo/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64"
IUSE=""

# gnu-efi contains only static libs, so there's no run-time dep on it
DEPEND=">=sys-boot/gnu-efi-3.0"
RDEPEND="sys-boot/efibootmgr
	sys-fs/dosfstools"
PROVIDE="virtual/bootloader"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/elilo-3.4-makefile.patch
	epatch "${FILESDIR}"/elilo-3.3a-devscheme.patch
}

src_compile() {
	local iarch
	case $(tc-arch) in
		ia64) iarch=ia64 ;;
		x86)  iarch=ia32 ;;
		*)    die "unknown architecture: $(tc-arch)" ;;
	esac

	# "prefix" on the next line specifies where to find gcc, as, ld,
	# etc.  It's not the usual meaning of "prefix".  By blanking it we
	# allow PATH to be searched.
	emake -j1 prefix= CC="$(tc-getCC)" ARCH=${iarch} || die "emake failed"
}

src_install() {
	newsbin "${FILESDIR}"/elilo-3.4 elilo || die "elilo failed"
	dosbin tools/eliloalt || die "eliloalt failed"

	exeinto /usr/lib/elilo
	doexe elilo.efi || die "elilo.efi failed"

	insinto /etc
	newins "${FILESDIR}"/elilo.conf.sample elilo.conf

	dodoc docs/* "${FILESDIR}"/elilo.conf.sample
	newman "${FILESDIR}"/elilo.8-3.4 elilo.8
	newman "${FILESDIR}"/eliloalt.8-3.4 eliloalt.8
}
