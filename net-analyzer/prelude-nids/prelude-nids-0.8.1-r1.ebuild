# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prelude-nids/prelude-nids-0.8.1-r1.ebuild,v 1.5 2004/01/26 00:57:43 vapier Exp $

DESCRIPTION="Prelude-IDS NIDS"
HOMEPAGE="http://www.prelude-ids.org"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc"
DEPEND="virtual/glibc
	!dev-libs/libprelude-cvs
	!net-analyzer/prelude-nids-cvs
	dev-libs/libprelude
	doc? ( dev-util/gtk-doc )"

RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6
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
	newins ${FILESDIR}/gentoo.init prelude-nids
	insinto /etc/conf.d
	insopts -m 644
	newins ${FILESDIR}/gentoo.conf prelude-nids
	into /usr/libexec/prelude
	insopts -m 755
	doins plugins/detects/snortrules/ruleset/convert_ruleset
	into /usr/share/prelude/ruleset
	mv ${D}/etc/prelude-nids/ruleset ${D}/usr/share/prelude/ruleset/nids
	dosym /usr/share/prelude/ruleset/nids /etc/prelude-nids/ruleset
}
