# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12-r2.ebuild,v 1.9 2004/10/31 05:25:01 vapier Exp $

inherit eutils flag-o-matic

CRYPT_PATCH_P="${PN}-2.11z-crypt-gentoo"
SELINUX_PATCH="util-linux-2.12-selinux.diff.bz2"
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	ftp://ftp.cwi.nl/pub/aeb/${PN}/${P}.tar.gz
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ia64"
IUSE="crypt nls static pam selinux"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )
	pam? ( sys-apps/pam-login )"
RDEPEND="${DEPEND} dev-lang/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}

#	use crypt && epatch ${DISTDIR}/${CRYPT_PATCH_P}.patch.bz2

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

	if ! use nls ; then
		sed -i -e 's/DISABLE_NLS=no/DISABLE_NLS=yes/' MCONFIG ||
			die "MCONFIG nls sed"
	fi

	# /bin/kill is provided by procps ONLY
	epatch ${FILESDIR}/${PN}-no-kill.patch
}

src_compile() {
	use static && append-ldflags -static
	econf || die "configure failed"
	emake || die "emake failed"
	cd sys-utils && makeinfo *.texi || die "makeinfo failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}
