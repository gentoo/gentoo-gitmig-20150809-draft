# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.1-r10.ebuild,v 1.14 2004/07/15 03:33:30 agriffis Exp $

IUSE=""

inherit eutils

DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa "

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	# Fix the relink problem where the relinked libs do not get
	# installed.  It is *VERY* important that you get a updated
	# 'libtool-${PV}-relink.patch' if you update this, as it
	# fixes a very serious bug.  Please not that this patch is
	# included in 'libtool-${PV}-gentoo.patch' for this ebuild.
	#
	# NOTE: all affected apps should get a 'libtoolize --copy --force'
	#      added to upate libtool
	#

	cd ${S}
	epatch ${FILESDIR}/${PV}/${P}-nonneg.patch
	epatch ${FILESDIR}/${PV}/${P}-relink.patch
	# Fixes quoting for test's .. *VERY* important!
	epatch ${FILESDIR}/${PV}/${P}-test.patch
	epatch ${FILESDIR}/${PV}/${P}-duplicate-dependency.patch
	# This breaks dependancies it seems
	# <azarah@gentoo.org> (20 Oct 2002)
	#epatch ${FILESDIR}/${PV}/${P}-ltmain.sh-hack.patch
	# Do not create bogus entries in $dependency_libs or $libdir
	# with ${D} or ${S} in them.
	#
	# Azarah - 07 April 2002
	epatch ${FILESDIR}/${PV}/${P}-portage.patch-v6
}

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS
}
