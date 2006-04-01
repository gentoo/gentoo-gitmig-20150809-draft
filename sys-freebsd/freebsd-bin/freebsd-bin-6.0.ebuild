# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-bin/freebsd-bin-6.0.ebuild,v 1.1 2006/04/01 16:43:50 flameeyes Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD /bin tools"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="rcp nls ssl"

SRC_URI="mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	ssl? ( dev-libs/openssl )
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	>=sys-devel/flex-2.5.31-r2"

S=${WORKDIR}/bin

PATCHES="${FILESDIR}/${PN}-${RV}-flex-2.5.31.patch"

pkg_setup() {
	use rcp || mymakeopts="${mymakeopts} NO_RCMNDS= "
	use nls || mymakeopts="${mymakeopts} NO_NLS= "

	# Sounds ridicoulus but ssl is used to enable des support in ed.
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	mymakeopts="${mymakeopts} NO_TCSH= NO_SENDMAIL= "
}

# csh and tcsh are provided by tcsh package, rmail is sendmail stuff.
REMOVE_SUBDIRS="csh rmail"
