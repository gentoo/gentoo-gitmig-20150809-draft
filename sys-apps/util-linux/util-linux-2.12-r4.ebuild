# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12-r4.ebuild,v 1.20 2004/11/14 04:26:01 vapier Exp $

inherit eutils flag-o-matic

CRYPT_PATCH_P="${P}-cryptoapi-losetup"
SELINUX_PATCH="util-linux-2.12-selinux.diff.bz2"
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	ftp://ftp.cwi.nl/pub/aeb/${PN}/${P}.tar.gz
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ~ppc64 s390 sh"
IUSE="crypt nls static pam selinux uclibc"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )
	pam? ( sys-apps/pam-login )
	crypt? ( app-crypt/hashalot )"
RDEPEND="${DEPEND}
	dev-lang/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# CryptoAPI losetup patch for the cryptoapi sepecific
	# to the 2.6 linux kernel. Needs hashalot.
	# Original patch location:
	# http://www.stwing.org/~sluskyb/util-linux/losetup-combined.patch
	# Mailing list post with info:
	# http://www.kerneli.org/pipermail/cryptoapi-devel/2003-September/000634.html
	# Follow thread for usage.
	use crypt && epatch ${DISTDIR}/${CRYPT_PATCH_P}.patch.bz2

	# Fix rare failures with -j4 or higher
	epatch ${FILESDIR}/${PN}-2.11z-parallel-make.patch

	# Fix unreadable df output
	epatch ${FILESDIR}/no-symlink-resolve.patch

	# access() is a macro which uses R_OK however
	# R_OK is not defined on sparc during a bootstrap 
	# unless we actually include unistd.h -solar (May 07 2004)
	epatch ${FILESDIR}/${PN}-2.12-swapon-unistd.patch

	# Add the O option to agetty to display DNS domainname in the issue
	# file, thanks to Marius Mauch <genone@genone.de>, bug #22275.
	#
	# NOTE:  Removing this will break future baselayout, so PLEASE
	#        consult with me before doing so.
	#
	# <azarah@gentoo.og> (17 Jul 2003)
	epatch ${FILESDIR}/${PN}-2.11z-agetty-domainname-option.patch

	# Add NFS4 support (kernel 2.5/2.6).
#	if use crypt ; then
#		epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4-crypt.dif
#	else
		epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4.dif
#	fi

	# <solar@gentoo.org> This patch should allow us to remove -fPIC
	# out of the filter-flags we need this be able to emit position
	# independent code so we can link our elf executables as shared
	# objects. "prelink" should now also be able to take advantage
	epatch ${FILESDIR}/${PN}-2.11z-pic.patch

	## see below for details on pic.patch
	case ${ARCH} in
		"x86"|"hppa"|"sparc"|"ppc"|"amd64")
			;;
		*)
			filter-flags -fPIC
			;;
	esac

	# Allow util-linux to compile with 2.6.x headers #31286
	epatch ${FILESDIR}/${P}-kernel-2.6.patch

	# Add support to read fat/fat32 labels, bug #36722
	epatch ${FILESDIR}/${P}-fat-LABEL-support.patch

	# Enable pam only if we use it
	use pam && sed -i "s:HAVE_PAM=no:HAVE_PAM=yes:" MCONFIG

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}

	sed -i \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:HAVE_SLN=no:HAVE_SLN=yes:" \
		-e "s:HAVE_TSORT=no:HAVE_TSORT=yes:" \
		-e "s:usr/man:usr/share/man:" \
		-e "s:usr/info:usr/share/info:" \
		-e "s:SUIDMODE=.*4755:SUIDMODE=4711:" \
		MCONFIG || die "MCONFIG sed"

	if ! use nls ; then
		sed -i -e 's/DISABLE_NLS=no/DISABLE_NLS=yes/' MCONFIG ||
			die "MCONFIG nls sed"
	fi

	# /bin/kill is provided by procps ONLY
	epatch ${FILESDIR}/${PN}-no-kill.patch

	use uclibc && sed -e 's/sys_siglist\[sig\]/strsignal(sig)/' -i ${S}/mount/fstab.c
}

src_compile() {
	append-ldflags -Wl,-z,now
	use static && append-ldflags -static
	export LDFLAGS

	econf || die "configure failed"

	emake || die "emake failed"
	cd sys-utils && makeinfo *.texi || die "makeinfo failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}

