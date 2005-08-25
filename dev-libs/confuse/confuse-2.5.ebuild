# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/confuse/confuse-2.5.ebuild,v 1.9 2005/08/25 03:22:07 agriffis Exp $

inherit eutils

DESCRIPTION="a configuration file parser library"
HOMEPAGE="http://www.nongnu.org/confuse/"
SRC_URI="http://savannah.nongnu.org/download/confuse/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc x86"
IUSE="doc debug nls test"

DEPEND="sys-devel/libtool
	test? ( dev-libs/check )
	doc? ( app-text/openjade
		>=app-text/docbook-sgml-dtd-3.1-r1 )"
RDEPEND=""

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-maketest.patch

	# keep this otherwise libraries will not have .so extensions
	use userland_Darwin || libtoolize --copy --force
}

src_compile() {
	local myconf

	use debug \
		&& myconf="${myconf} --enable-debug=all" \
		|| myconf="${myconf} --disable-debug"

	econf \
		--enable-shared \
		$(use_enable doc build-docs) \
		$(use_enable nls) \
		${myconf} || die
	emake || die
}

src_test() {
	cd "${S}"/tests
	./check_confuse || die "self test failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
	if use doc ; then
		dohtml doc/html/*.html || die
	fi
	rmdir "${D}"/usr/bin
}
