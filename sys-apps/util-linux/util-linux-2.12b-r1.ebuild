# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12b-r1.ebuild,v 1.2 2004/10/31 05:25:01 vapier Exp $

inherit eutils flag-o-matic

CRYPT_PATCH_P="${PN}-2.12b-cryptoapi-losetup"
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	ftp://ftp.cwi.nl/pub/aeb/${PN}/${P}.tar.gz
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="crypt nls static pam selinux uclibc"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )
	pam? ( sys-apps/pam-login )
	crypt? ( app-crypt/hashalot )"
# We need perl because one script ( chkdupexe ) is
# written in frickin perl; otherwise we dont need it ...
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
#	use crypt \
#		&& epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4-crypt.dif \
#		||
	epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4.dif

	# <solar@gentoo.org> This patch should allow us to remove -fPIC
	# out of the filter-flags we need this be able to emit position
	# independent code so we can link our elf executables as shared
	# objects. "prelink" should now also be able to take advantage
	epatch ${FILESDIR}/${P}-pic.patch

	## see below for details on pic.patch
	case ${ARCH} in
		"x86"|"hppa"|"sparc"|"ppc"|"amd64")
			;;
		*)
			filter-flags -fPIC
			;;
	esac

	# Add support to read fat/fat32 labels, bug #36722
	epatch ${FILESDIR}/${P}-fat-LABEL-support.patch

	# Add support for gcloop
	use crypt || epatch ${FILESDIR}/${P}-gcloop.patch
	use crypt && epatch ${FILESDIR}/${P}-gcloop-with-crypt.patch

	# Enable pam only if we use it
	use pam && sed -i "s:HAVE_PAM=no:HAVE_PAM=yes:" MCONFIG

	use selinux && sed -i "s:HAVE_SELINUX=no:HAVE_SELINUX=yes:" MCONFIG

	sed -i \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:HAVE_KILL=no:HAVE_KILL=yes:" \
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

	# 2.6 kernels have a broken blkpg.h (if included in userspace ...)
	if [ -n "`grep __user /usr/include/linux/blkpg.h`" ] ; then
		mkdir ${S}/partx/linux
		sed -e 's:__user::g' /usr/include/linux/blkpg.h > \
			${S}/partx/linux/blkpg.h
	fi

	# Install rdev on amd64 platform
	epatch ${FILESDIR}/${PN}-2.12-amd64_rdev_installation.patch

	# swapon gets confused by symlinks in /dev #69162
	epatch ${FILESDIR}/${PN}-swapon-check-symlinks.patch

	use uclibc && sed -e 's/sys_siglist\[sig\]/strsignal(sig)/' -i ${S}/mount/fstab.c
}

src_compile() {
	# opt to use non-lazy bindings for suids installed by this package.
	append-ldflags -Wl,-z,now
	use static && append-ldflags -static
	econf || die "configure failed"
	emake || die "emake failed"
	if [ ! -x "partx/partx" ] ; then
		cd ${S}/partx
		CFLAGS="-I." \
		make || die "make partx failed"
	else
		ewarn "Build system now builds partx!"
	fi
	cd ${S}/sys-utils && makeinfo *.texi || die "makeinfo failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	if [ ! -x "${D}/sbin/partx" ] ; then
		into /
		dosbin partx/{addpart,delpart,partx}
	else
		ewarn "Build system now installs partx!"
	fi

	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}
