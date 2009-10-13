# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-bin/freebsd-bin-6.2.ebuild,v 1.4 2009/10/13 17:02:08 ulm Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD /bin tools"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE="nls"

SRC_URI="mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	dev-libs/libedit
	sys-libs/ncurses
	sys-apps/ed
	!app-misc/realpath"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	>=sys-devel/flex-2.5.31-r2"

S=${WORKDIR}/bin

PATCHES="${FILESDIR}/${PN}-6.0-flex-2.5.31.patch
		${FILESDIR}/${PN}-6.2-mkdir-posix.patch
		${FILESDIR}/${PN}-6.2-sh-libedit.patch
		${FILESDIR}/${PN}-6.2-sh-cclass.patch"

pkg_setup() {
	use nls || mymakeopts="${mymakeopts} NO_NLS= "

	mymakeopts="${mymakeopts} NO_TCSH= NO_SENDMAIL= NO_OPENSSL= NO_CRYPT= NO_RCMDS= "
}

# csh and tcsh are provided by tcsh package, rmail is sendmail stuff.
REMOVE_SUBDIRS="csh rmail ed"
