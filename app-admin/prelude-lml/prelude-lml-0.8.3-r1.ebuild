# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-lml/prelude-lml-0.8.3-r1.ebuild,v 1.2 2003/06/30 14:15:04 solar Exp $

DESCRIPTION="Prelude-IDS Log Monitoring Lackey"
HOMEPAGE="http://www.prelude-ids.org"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="virtual/glibc
	!dev-libs/libprelude-cvs
	!app-admin/prelude-lml-cvs
	dev-libs/libprelude
	dev-libs/libpcre
	doc? ( dev-util/gtk-doc )"

RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	export WANT_AUTOCONF_2_5="1"
	export WANT_AUTOMAKE_1_6="1"
	export MAKEOPTS=""	# Doesn't compile if you using make -j
	
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"
	
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
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/gentoo.init prelude-lml
	insinto /etc/conf.d
	insopts -m 644
	newins ${FILESDIR}/gentoo.conf prelude-lml
	into /usr/share/prelude/ruleset	
	mv ${D}/etc/prelude-lml/ruleset ${D}/usr/share/prelude/ruleset/lml
	dosym /usr/share/prelude/ruleset/lml /etc/prelude-lml/ruleset
}
