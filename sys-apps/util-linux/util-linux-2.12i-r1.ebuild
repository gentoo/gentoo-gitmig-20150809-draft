# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12i-r1.ebuild,v 1.1 2004/11/14 08:46:54 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

AES_VER="2.2d"
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	crypt? (
		mirror://gentoo/util-linux-2.12i-cryptoapi-losetup.patch.bz2
		http://dev.gentoo.org/~vapier/dist/util-linux-2.12i-cryptoapi-losetup.patch.bz2
	)"
#	crypt? ( http://loop-aes.sourceforge.net/loop-AES/loop-AES-v${AES_VER}.tar.bz2 )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="crypt nls static pam selinux perl"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )
	pam? ( sys-apps/pam-login )
	crypt? ( app-crypt/hashalot )"
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl )
	nls? ( sys-devel/gettext )"

yesno() { useq $1 && echo yes || echo no; }

src_unpack() {
	unpack ${A}
	cd ${S}

	# crypto support, yummy #24458
	#use crypt && epatch ${WORKDIR}/loop-AES-v${AES_VER}/util-linux-*.diff
	use crypt && epatch ${WORKDIR}/util-linux-2.12i-cryptoapi-losetup.patch

	# Fix rare failures with -j4 or higher
	epatch ${FILESDIR}/${PN}-2.11z-parallel-make.patch

	# Fix unreadable df output
	epatch ${FILESDIR}/no-symlink-resolve.patch

	# Add the O option to agetty to display DNS domainname in the issue
	# file, thanks to Marius Mauch <genone@genone.de>, bug #22275.
	#
	# NOTE:  Removing this will break future baselayout, so PLEASE
	#        consult with me before doing so.
	#
	# <azarah@gentoo.org> (17 Jul 2003)
	epatch ${FILESDIR}/${PN}-2.11z-agetty-domainname-option.patch

	# Add NFS4 support (kernel 2.5/2.6)
	epatch ${FILESDIR}/${P}-nfsv4.patch

	# ignore managed/kudzu options #70873
	epatch ${FILESDIR}/${P}-ignore-managed.patch

	# Allow util-linux to be built with -fPIC
	epatch ${FILESDIR}/${P}-pic.patch

	# Add support to read fat/fat32 labels, bug #36722
	epatch ${FILESDIR}/${P}-fat-LABEL-support.patch
	epatch ${S}/mount-2.12-fat.patch

	# Install rdev on amd64 platform
	epatch ${FILESDIR}/${PN}-2.12-amd64_rdev_installation.patch

	# swapon gets confused by symlinks in /dev #69162
	epatch ${FILESDIR}/${P}-swapon-check-symlinks.patch

	# Add support for gcloop
# use squashfs :P
#	use crypt || epatch ${FILESDIR}/${PN}-2.12b-gcloop.patch
#	use crypt && epatch ${FILESDIR}/${PN}-2.12b-gcloop-with-crypt.patch

	# Enable random features
	sed -i \
		-e "/^HAVE_PAM=/s:no:$(yesno pam):" \
		-e "/^HAVE_SELINUX=/s:no:$(yesno selinux):" \
		-e "/^DISABLE_NLS=/s:no:$(yesno !nls):" \
		-e "/^HAVE_KILL=/s:no:yes:" \
		-e "/^HAVE_SLN=/s:no:yes:" \
		-e "/^HAVE_TSORT/s:no:yes:" \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:usr/man:usr/share/man:" \
		-e "s:usr/info:usr/share/info:" \
		-e "s:SUIDMODE=.*4755:SUIDMODE=4711:" \
		MCONFIG || die "MCONFIG sed"
}

src_compile() {
	append-ldflags -Wl,-z,now
	use static && append-ldflags -static
	export CC="$(tc-getCC)"

	econf || die "configure failed"
	emake || die "emake failed"

	cd partx
	emake CFLAGS="${CFLAGS} -include linux/compiler.h" || die "make partx failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dosbin partx/{addpart,delpart,partx} || die "dosbin"
	use perl || rm -f "${D}"/usr/bin/chkdupexe

	dodoc HISTORY MAINTAINER README VERSION
	docinto examples
	dodoc example.files/*
}
