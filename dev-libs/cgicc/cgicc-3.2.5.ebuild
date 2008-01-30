# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgicc/cgicc-3.2.5.ebuild,v 1.1 2008/01/30 11:23:26 dev-zero Exp $

DESCRIPTION="A C++ class library for writing CGI applications"
HOMEPAGE="http://www.cgicc.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="LGPL-3 doc? ( FDL-1.2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove stray GNUCAP_LDFLAGS
	# upstream bug: #22176
	sed -i \
		-e 's/@GNUCAP_LDFLAGS@//' \
		cgicc/Makefile.in || die "sed failed"

	# Fix docdir/htmldir paths in doc/Makefile.in
	# upstream bug: #6385
	sed -i \
		-e 's|$(docdir)|@htmldir@|g' \
		-e 's|$(prefix)/doc/\$(PACKAGE)-\$(VERSION)|@docdir@|' \
		doc/Makefile.in || die "sed failed"
}

src_compile() {

	if ! use doc ; then
		sed -i \
			-e 's/^\(SUBDIRS = .*\) doc \(.*\)/\1 \2/' \
			Makefile.in || die "sed failed"
	fi

	econf \
		--disable-demos \
		--htmldir=/usr/share/doc/${PF}/html \
		$(use_enable debug debug-logging) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS README* THANKS

	# Manually install the m4-file
	# upstream bug: #22177
	insinto /usr/share/aclocal
	doins example/cgicc.m4

	if use doc ; then
		insinto /usr/share/doc/${PF}/contrib
		doins contrib/*.cpp contrib/README

		insinto /usr/share/doc/${PF}/demo
		doins -r demo/*.{h,cpp} demo/images demo/README
	fi
}
