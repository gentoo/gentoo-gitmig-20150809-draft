# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11z-r8.ebuild,v 1.8 2004/10/31 05:25:01 vapier Exp $

inherit eutils flag-o-matic

## see below for details on pic.patch
# Added back for now until other archs can be tested.

CRYPT_PATCH_P="${P}-crypt-gentoo"
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.bz2
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"

KEYWORDS="x86 amd64 ppc sparc alpha mips hppa"
SLOT="0"
LICENSE="GPL-2"
IUSE="crypt nls static pam"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r2
	pam? ( sys-apps/pam-login )"
RDEPEND="${DEPEND}
	dev-lang/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}

	if use crypt ; then
		epatch ${DISTDIR}/${CRYPT_PATCH_P}.patch.bz2
	fi

	# Fix rare failures with -j4 or higher
	epatch ${FILESDIR}/${P}-parallel-make.patch

	# Fix unreadable df output
	epatch ${FILESDIR}/no-symlink-resolve.patch

	# Support the upcoming "script -c COMMAND" feature now.
	epatch ${FILESDIR}/${P}-script.patch

	# Add the O option to agetty to display DNS domainname in the issue
	# file, thanks to Marius Mauch <genone@genone.de>, bug #22275.
	#
	# NOTE:  Removing this will break future baselayout, so PLEASE
	#        consult with me before doing so.
	#
	# <azarah@gentoo.og> (17 Jul 2003)
	epatch ${FILESDIR}/${P}-agetty-domainname-option.patch

	# <kumba@gentoo.org> (22 Apr 2003)
	# Fix fdisk so it works on SGI Disk Labels and lets the user
	# Actually select a partition, rather than automatically
	# choosing "4".
	if [ "${ARCH}" = "mips" ]
	then
		epatch ${FILESDIR}/${P}-mips-fdisk-fix.patch
	fi

	# <solar@gentoo.org> This patch should allow us to remove -fPIC
	# out of the filter-flags we need this be able to emit position
	# independent code so we can link our elf executables as shared
	# objects. "prelink" should now also be able to take advantage
	epatch ${FILESDIR}/${P}-pic.patch

	#enable pam only if we use it
	use pam && sed -i "s:HAVE_PAM=no:HAVE_PAM=yes:" MCONFIG

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

	# /bin/kill will come from procps only
	epatch ${FILESDIR}/${PN}-no-kill.patch
}

src_compile() {

	filter-flags -fPIC

	if use static ; then
		append-ldflags "-static"
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
