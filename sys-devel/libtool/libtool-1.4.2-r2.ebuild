# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.2-r2.ebuild,v 1.5 2003/09/06 08:06:35 msterret Exp ${P}-r1.ebuild,v 1.8 2002/10/04 06:34:42 vapier Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"


pkg_setup() {
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_5=1
}

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
	epatch ${FILESDIR}/${PV}/${PN}-1.3.5-mktemp.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4-nonneg.patch
	epatch ${FILESDIR}/${PV}/${P}-test.patch
	epatch ${FILESDIR}/${PV}/${P}-relink.patch
	epatch ${FILESDIR}/${PV}/${P}-add-x11r6-lib-in-ignores-for-rpath.patch
	epatch ${FILESDIR}/${PV}/${P}-duplicate-dependency.patch
	epatch ${FILESDIR}/${PV}/${P}-fix-linkage-of-cxx-code-with-gcc.patch
	epatch ${FILESDIR}/${PV}/${P}-lib64.patch
	epatch ${FILESDIR}/${PV}/${P}-archive-shared.patch
	# This breaks dependancies it seems
	# <azarah@gentoo.org> (20 Oct 2002)
	#epatch ${FILESDIR}/${PV}/${PN}-1.4.1-ltmain.sh-hack.patch
	# Do not create bogus entries in $dependency_libs or $libdir
	# with ${D} or ${S} in them.
	#
	# Azarah - 07 April 2002
	epatch ${FILESDIR}/${PV}/${P}-portage.patch
}

src_compile() {
	#we do not wat to libtoolize this build.
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

