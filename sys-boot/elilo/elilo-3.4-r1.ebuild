# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/elilo/elilo-3.4-r1.ebuild,v 1.1 2005/03/30 19:50:57 plasmaroo Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Linux boot loader for EFI-based systems such as IA-64"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="ftp://ftp.hpl.hp.com/pub/linux-ia64/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64"
IUSE=""

# gnu-efi contains only static libs, so there's no run-time dep on it
DEPEND=">=sys-boot/gnu-efi-3.0"
RDEPEND="sys-boot/efibootmgr
	sys-fs/dosfstools"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/elilo-3.4-makefile.patch
	epatch ${FILESDIR}/elilo-3.3a-devscheme.patch
}

src_compile() {
	local iarch
	case $ARCH in
		ia64) iarch=ia64 ;;
		x86)  iarch=ia32 ;;		# for cross-compiling?
		*)    die "unknown architecture: $ARCH" ;;
	esac

	# "prefix" on the next line specifies where to find gcc, as, ld,
	# etc.  It's not the usual meaning of "prefix".  By blanking it we
	# allow PATH to be searched.
	emake -j1 prefix= CC="$(tc-getCC)" ARCH=${iarch} || die "emake failed"

	# unversion the man-pages and Debian's elilo script
	cp ${FILESDIR}/elilo.8-${PV} elilo.8
	cp ${FILESDIR}/eliloalt.8-${PV} eliloalt.8
	cp ${FILESDIR}/elilo-${PV} elilo
}

src_install() {
	dodir /usr/lib/elilo /usr/sbin /etc

	# install the efi executable in a known location
	install -m755 elilo.efi ${D}/usr/lib/elilo || die

	# install eliloalt
	install -m755 tools/eliloalt ${D}/usr/sbin || die
	doman eliloalt.8 || die

	# text docs
	dodoc docs/*

	# install the debian elilo script
	install -m755 elilo ${D}/usr/sbin || die
	install -m644 ${FILESDIR}/elilo.conf.sample ${D}/etc || die
	doman elilo.8 || die
}
