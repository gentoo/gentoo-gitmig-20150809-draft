# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.3-r1.ebuild,v 1.2 2003/06/28 02:11:06 kumba Exp ${P}-r1.ebuild,v 1.8 2002/10/04 06:34:42 vapier Exp $

IUSE=""

inherit eutils

# NOTE:  We install libltdl of libtool-1.3x for compat reasons ...

OLD_PV="1.3.5"
S="${WORKDIR}/${P}"
OLD_S="${WORKDIR}/${PN}-${OLD_PV}"
DESCRIPTION="A shared library tool for developers"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gnu/${PN}/${PN}-${OLD_PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~mips"

DEPEND="virtual/glibc"


lt_setup() {
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_5=1
}

src_unpack() {
	lt_setup

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
	cd ${OLD_S}
	epatch ${FILESDIR}/${PV}/${PN}-1.2f-cache.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.3.5-nonneg.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.3.5-mktemp.patch

	cd ${S}
	# Redhat patches
	epatch ${FILESDIR}/${PV}/${PN}-1.3.5-mktemp.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4-nonneg.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-s390_x86_64.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-relink-58664.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-multilib.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-demo.patch
	# Mandrake patches
	epatch ${FILESDIR}/${PV}/${PN}-1.4.3-lib64.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-add-x11r6-lib-in-ignores-for-rpath.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-fix-linkage-of-cxx-code-with-gcc.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-archive-shared.patch
	epatch ${FILESDIR}/${PV}/${PN}-1.4.3-ltmain-SED.patch
	# Do not create bogus entries in $dependency_libs or $libdir
	# with ${D} or ${S} in them.
	#
	# Azarah - 07 April 2002
	epatch ${FILESDIR}/${PV}/${PN}-1.4.2-portage.patch
}

src_compile() {
	lt_setup

	#
	# ************ libtool-1.3x ************
	#

	cd ${OLD_S}
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info || die

	emake || die

	#
	# ************ libtool-1.4x ************
	#

	cd ${S}
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info || die

	emake || die
}

src_install() {
	#
	# ************ libtool-1.3x ************
	#

	cd ${OLD_S}/libltdl; make DESTDIR=${D} install || die

	# Remove stuff we are not going to use ...
	for x in libltdl.a  libltdl.la  libltdl.so
	do
		[ -f ${x} ] && rm -f ${D}/usr/lib/${x}
	done
	rm -rf ${D}/usr/include

	#
	# ************ libtool-1.4x ************
	#

	cd ${S}; make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	
}

