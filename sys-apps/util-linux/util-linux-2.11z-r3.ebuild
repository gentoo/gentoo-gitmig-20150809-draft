# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11z-r3.ebuild,v 1.5 2003/05/25 15:26:46 mholzer Exp $

IUSE="crypt nls selinux static pam"

inherit eutils flag-o-matic

filter-flags -fPIC

S=${WORKDIR}/${P}
CRYPT_PATCH_P="${P}-crypt-gentoo"
DESCRIPTION="Various useful Linux utilities"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.bz2
	crypt? ( mirror://gentoo/${CRYPT_PATCH_P}.patch.bz2 )"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha arm ~mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sed-4.0.5
	>=sys-libs/ncurses-5.2-r2
	!selinux? ( sys-apps/pam-login )
	selinux? ( sys-apps/shadow )
	pam? ( sys-apps/pam-login )"

RDEPEND="${DEPEND} dev-lang/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}

	if [ ! -z "`use crypt`" ] ; then
		epatch ${DISTDIR}/${CRYPT_PATCH_P}.patch.bz2
	fi

	# Fix rare failures with -j4 or higher
	epatch ${FILESDIR}/${P}-parallel-make.patch

	# Fix unreadable df output
	epatch ${FILESDIR}/no-symlink-resolve.patch

	# <kumba@gentoo.org> (22 Apr 2003)
	# Fix fdisk so it works on SGI Disk Labels and lets the user
	# Actually select a partition, rather than automatically
	# choosing "4".
	if [ "${ARCH}" = "mips" ]
	then
		epatch ${FILESDIR}/${P}-mips-fdisk-fix.patch
	fi

	#enable pam only if we use it
	use pam && sed -i "s:HAVE_PAM=no:HAVE_PAM=yes:" MCONFIG || die "MCONFIG Pam"

	sed -i \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:HAVE_PAM=no:HAVE_PAM=yes:" \
		-e "s:HAVE_SLN=no:HAVE_SLN=yes:" \
		-e "s:HAVE_TSORT=no:HAVE_TSORT=yes:" \
		-e "s:usr/man:usr/share/man:" \
		-e "s:usr/info:usr/share/info:" \
		MCONFIG || die "MCONFIG sed"

	if [ -z "`use nls`" ] ; then
		sed -i -e 's/DISABLE_NLS=no/DISABLE_NLS=yes/' MCONFIG ||
			die "MCONFIG nls sed"
	fi
}

src_compile() {

	econf || die "configure failed"

	if [ "`use static`" ] ; then
		export LDFLAGS=-static
	fi
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
