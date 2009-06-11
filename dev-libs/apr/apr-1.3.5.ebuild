# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-1.3.5.ebuild,v 1.4 2009/06/11 05:43:42 maekke Exp $

EAPI="2"

inherit autotools eutils libtool multilib

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="debug doc +urandom"
RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	AT_M4DIR="build" eautoreconf
	elibtoolize

	epatch "${FILESDIR}/config.layout.patch"
}

src_configure() {
	local myconf

	if use debug; then
		myconf+=" --enable-maintainer-mode --enable-pool-debug=all"
	fi

	if use urandom; then
		myconf+=" --with-devrandom=/dev/urandom"
	else
		myconf+=" --with-devrandom=/dev/random"
	fi

	econf --enable-layout=gentoo \
		--enable-nonportable-atomics \
		--enable-threads \
		${myconf}

	# Make sure we use the system libtool.
	sed -i 's,$(apr_builddir)/libtool,/usr/bin/libtool,' build/apr_rules.mk
	sed -i 's,${installbuilddir}/libtool,/usr/bin/libtool,' apr-1-config
	rm -f libtool
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		emake dox || die "emake dox failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGES NOTICE

	if use doc; then
		dohtml docs/dox/html/* || die "dohtml failed"
	fi

	# This file is only used on AIX systems, which Gentoo is not,
	# and causes collisions between the SLOTs, so remove it.
	rm -f "${D}usr/$(get_libdir)/apr.exp"
}
