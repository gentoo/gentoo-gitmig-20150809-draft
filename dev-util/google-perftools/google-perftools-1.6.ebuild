# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/google-perftools/google-perftools-1.6.ebuild,v 1.4 2012/06/07 21:32:04 zmedico Exp $

EAPI=2

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Fast, multi-threaded malloc() and nifty performance analysis tools"
HOMEPAGE="http://code.google.com/p/google-perftools/"
SRC_URI="http://google-perftools.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="largepages +debug minimal" # test"

DEPEND="sys-libs/libunwind"
RDEPEND="${DEPEND}"

# tests get stuck in a deadlock due to sandbox interactions.
# bug #290249.
RESTRICT=test

pkg_setup() {
	# set up the make options in here so that we can actually make use
	# of them on both compile and install.

	# Avoid building the unit testing if we're not going to execute
	# tests; this trick here allows us to ignore the tests without
	# touching the build system (and thus without rebuilding
	# autotools). Keep commented as long as it's restricted.

	# use test && \
		makeopts="${makeopts} noinst_PROGRAMS= "

	# don't install _anything_ from the documentation, since it would
	# install it in non-standard locations, and would just waste time.
	makeopts="${makeopts} dist_doc_DATA= "
}

src_configure() {
	use largepages && append-cppflags -DTCMALLOC_LARGE_PAGES

	econf \
		--disable-static \
		--disable-dependency-tracking \
		--enable-fast-install \
		$(use_enable debug debugalloc) \
		$(use_enable minimal)
}

src_compile() {
	emake ${makeopts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install ${makeopts} || die "emake install failed"

	# Remove libtool files since we dropped the static libraries
	find "${D}" -name '*.la' -delete

	dodoc README AUTHORS ChangeLog TODO NEWS || die
	pushd doc
	dohtml -r * || die
	popd
}
