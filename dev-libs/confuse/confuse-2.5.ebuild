# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/confuse/confuse-2.5.ebuild,v 1.1 2004/12/05 03:09:05 dragonheart Exp $

inherit eutils

DESCRIPTION="libConfuse is a configuration file parser library,"
HOMEPAGE="http://www.nongnu.org/confuse/"
SRC_URI="http://savannah.nongnu.org/download/confuse/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc debug nls"

DEPEND="sys-devel/libtool
	doc? ( app-text/openjade
		>=app-text/docbook-sgml-dtd-3.1-r1 )"

RDEPEND="virtual/libc"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-maketest.patch
}

src_compile() {
	local myconf

	# keep this otherwise libraries will not have .so extensions
	libtoolize --force

	use debug \
		&& myconf="${myconf} --enable-debug=all" \
		|| myconf="${myconf} --disable-debug"

	econf `use_enable doc build-docs` `use_enable nls` ${myconf} || die
	emake || die
}

src_test() {
	cd ${S}/tests
	./check_confuse || die "self test failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README || die
	if use doc; then
		dohtml doc/html/*.html || die
	fi
	rmdir ${D}/usr/bin
}
