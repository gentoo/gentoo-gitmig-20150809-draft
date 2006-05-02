# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-share/freebsd-share-6.1_rc2.ebuild,v 1.1 2006/05/02 22:00:44 flameeyes Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD shared tools/files"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="doc isdn"

SRC_URI="mirror://gentoo/${SHARE}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${GNU}.tar.bz2
	mirror://gentoo/${UBIN}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2
	mirror://gentoo/${SBIN}.tar.bz2
	mirror://gentoo/${BIN}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2"

DEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*"
RDEPEND=""

RESTRICT="nostrip"

S="${WORKDIR}/share"

pkg_setup() {
	use isdn || mymakeopts="${mymakeopts} NO_I4B= "
	use doc || mymakeopts="${mymakeopts} NO_SHAREDOCS= "

	mymakeopts="${mymakeopts} NO_SENDMAIL= "
}

REMOVE_SUBDIRS="mk termcap zoneinfo"

PATCHES="${FILESDIR}/${PN}-5.3-doc-locations.patch
	${FILESDIR}/${PN}-5.4-gentoo-skel.patch
	${FILESDIR}/${PN}-6.0-links.patch"

src_unpack() {
	freebsd_src_unpack

	# Remove make.conf manpage as it describes bsdmk's make.conf.
	sed -i -e 's:make.conf.5::' ${S}/man/man5/Makefile
	# Don't install the arch-specific directories in subdirectories
	sed -i -e '/MANSUBDIR/d' ${S}/man/man4/man4.{alpha,i386,sparc64}/Makefile

	# Remove them so that they can't be included by error
	rm -rf ${S}/mk/*.mk
}

src_compile() {
	export ESED="/usr/bin/sed"

	# This is a groff problem and not a -shared problem.
	export GROFF_TMAC_PATH="/usr/share/tmac/:/usr/share/groff/1.19.1/tmac/"
	mkmake || die "emake failed"
}

src_install() {
	mkmake DESTDIR=${D} DOCDIR=/usr/share/doc/${PF} install || die "Install failed"
}
