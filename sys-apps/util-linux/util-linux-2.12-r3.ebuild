# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12-r3.ebuild,v 1.3 2003/12/17 04:11:49 brad_mssw Exp $

IUSE="crypt nls static pam selinux"

inherit eutils flag-o-matic

## see below for details on pic.patch
case ${ARCH} in
	"x86"|"hppa"|"sparc"|"ppc")
		;;
	*)
		filter-flags -fPIC
		;;
esac

S="${WORKDIR}/${P}"
CRYPT_PATCH_P="${P}-cryptoapi-losetup"
SELINUX_PATCH="util-linux-2.12-selinux.diff.bz2"
DESCRIPTION="Various useful Linux utilities"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	ftp://ftp.cwi.nl/pub/aeb/${PN}/${P}.tar.gz
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~arm ~mips ~hppa ~ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-apps/sed-4.0.5
	>=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )
	pam? ( sys-apps/pam-login )
	crypt? ( app-crypt/hashalot )"

RDEPEND="${DEPEND} dev-lang/perl
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

	# Add the O option to agetty to display DNS domainname in the issue
	# file, thanks to Marius Mauch <genone@genone.de>, bug #22275.
	#
	# NOTE:  Removing this will break future baselayout, so PLEASE
	#        consult with me before doing so.
	#
	# <azarah@gentoo.og> (17 Jul 2003)
	epatch ${FILESDIR}/${PN}-2.11z-agetty-domainname-option.patch

	# Add NFS4 support (kernel 2.5/2.6).
#	if [ ! -z "`use crypt`" ] ; then
#		epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4-crypt.dif
#	else
		epatch ${FILESDIR}/${PN}-2.11z-01-nfsv4.dif
#	fi

	# <solar@gentoo.org> This patch should allow us to remove -fPIC
	# out of the filter-flags we need this be able to emit position
	# independent code so we can link our elf executables as shared
	# objects. "prelink" should now also be able to take advantage
	epatch ${FILESDIR}/${PN}-2.11z-pic.patch

	# allow util-linux to compile with 2.6.x headers #31286
	epatch ${FILESDIR}/${P}-kernel-2.6.patch

	#enable pam only if we use it
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

	if [ -z "`use nls`" ] ; then
		sed -i -e 's/DISABLE_NLS=no/DISABLE_NLS=yes/' MCONFIG ||
			die "MCONFIG nls sed"
	fi

	# /bin/kill is provided by procps ONLY
	epatch ${FILESDIR}/${PN}-no-kill.patch
}

src_compile() {
	if [ "`use static`" ] ; then
		export LDFLAGS="${LDFLAGS} -static"
	fi

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

