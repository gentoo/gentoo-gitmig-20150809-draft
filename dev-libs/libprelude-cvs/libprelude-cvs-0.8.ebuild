# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libprelude-cvs/libprelude-cvs-0.8.ebuild,v 1.1 2003/08/06 18:41:42 solar Exp $

inherit eutils

ECVS_SERVER="cvs.prelude-ids.org:/cvsroot/prelude"
ECVS_MODULE="libprelude"
ECVS_BRANCH="${ECVS_MODULE}-`echo ${PV} | sed s:\\\.:-:g`"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"
inherit cvs
S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="Prelude-IDS Framework Library"
HOMEPAGE="http://www.prelude-ids.org"
# SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl doc"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )
	doc? ( dev-util/gtk-doc )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	export WANT_AUTOCONF_2_5="1"
	export WANT_AUTOMAKE_1_6="1"
	
	use ssl && myconf="${myconf} --enable-openssl" || myconf="${myconf} --disable-openssl"
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	
	aclocal -I /usr/share/aclocal
	autoconf
	autoheader
	libtoolize -c --force --ltdl --automake
	automake --gnu -a -c
	cd libltdl
	mv configure.in configure.in.tmp
	echo "AC_PREREQ(2.50)" > configure.in
	cat configure.in.tmp >> configure.in
	rm -f configure.in.tmp
	aclocal -I /usr/share/aclocal
	autoconf
	autoheader
	libtoolize -c --force --ltdl --automake
	automake --gnu -a -c
	cd ..
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
