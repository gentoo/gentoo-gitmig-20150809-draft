# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/elilo/elilo-3.4.ebuild,v 1.3 2004/01/23 16:42:28 agriffis Exp $

DESCRIPTION="Linux boot loader for EFI-based systems such as IA-64"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="ftp://ftp.hpl.hp.com/pub/linux-ia64/${P}.tar.gz"
KEYWORDS="~ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# gnu-efi contains only static libs, so there's no run-time dep on it
DEPEND=">=gnu-efi-3.0"
RDEPEND="sys-boot/efibootmgr sys-fs/dosfstools"

src_unpack() {
	unpack ${A} && cd ${S} || die "failed to unpack"
	epatch ${FILESDIR}/elilo-3.4-makefile.patch || die "epatch failed"
	epatch ${FILESDIR}/elilo-3.3a-devscheme.patch || die "epatch failed"
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
	emake -j1 prefix= CC="${CC}" ARCH=${iarch} || die "emake failed"

	# unversion the man-pages and Debian's elilo script
	cp ${FILESDIR}/elilo.8-${PV} elilo.8
	cp ${FILESDIR}/eliloalt.8-${PV} eliloalt.8
	cp ${FILESDIR}/elilo-${PV} elilo
}

src_install() {
	dodir /usr/lib/elilo || die
	dodir /usr/sbin || die
	dodir /etc || die

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
