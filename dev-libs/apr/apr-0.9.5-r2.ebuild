# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-0.9.5-r2.ebuild,v 1.2 2005/03/21 19:43:00 beu Exp $

inherit flag-o-matic libtool

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6"
RESTRICT="test"

DEPEND=""

# this function shall maybe go into flag-o-matic.eclass
lfs-flags() {
	echo -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
}

# returns true, if LFS is supported (and supposed to be bugfree ;) by current system
supports-lfs() {
	# sparc has issues with 64bit IO
	use sparc && return 1

	# for some reason (I do not know who wrote this) we do not want LFS on glibc-2.2
	# maybe it's broken then

	has_version '>=sys-libs/glibc-2.3*' && return 0
	has_version '=sys-libs/glibc-2.2*'  && return 1
	return 0
}

set_filter_flags() {
	CFLAGS="${CFLAGS/  / }"

	supports-lfs && append-lfs-flags || filter-lfs-flags
}

src_compile() {
	elibtoolize || die "elibtoolize failed"
	set_filter_flags

	myconf="--datadir=/usr/share/apr-0"

	myconf="${myconf} $(use_enable ipv6)"
	myconf="${myconf} --enable-threads"
	myconf="${myconf} --enable-nonportable-atomics"
	myconf="${myconf} --with-devrandom=/dev/random"

	econf ${myconf} || die
	emake || die
}

src_install() {
	set_filter_flags

	make DESTDIR="${D}" installbuilddir=/usr/share/apr-0/build install || die

	# bogus values pointing at /var/tmp/portage
	sed -i -e 's:APR_SOURCE_DIR=.*:APR_SOURCE_DIR=/usr/share/apr-0:g' ${D}/usr/bin/apr-config
	sed -i -e 's:APR_BUILD_DIR=.*:APR_BUILD_DIR=/usr/share/apr-0/build:g' ${D}/usr/bin/apr-config

	sed -i -e 's:apr_builddir=.*:apr_builddir=/usr/share/apr-0/build:g' ${D}/usr/share/apr-0/build/apr_rules.mk
	sed -i -e 's:apr_builders=.*:apr_builders=/usr/share/apr-0/build:g' ${D}/usr/share/apr-0/build/apr_rules.mk

	# fix apr-config to reflect LFS
	supports-lfs && \
		sed -i -e "s:CPPFLAGS=\"\\(.*\\)\":CPPFLAGS=\"\\1 `lfs-flags`\":" ${D}/usr/bin/apr-config

	cp -p build/*.awk ${D}/usr/share/apr-0/build
	cp -p build/*.sh ${D}/usr/share/apr-0/build
	cp -p build/*.pl ${D}/usr/share/apr-0/build

	dodoc CHANGES LICENSE NOTICE
}
