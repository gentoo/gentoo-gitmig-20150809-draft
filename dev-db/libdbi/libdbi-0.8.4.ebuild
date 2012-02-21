# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi/libdbi-0.8.4.ebuild,v 1.1 2012/02/21 08:55:32 robbat2 Exp $

EAPI=4

inherit eutils autotools multilib

DESCRIPTION="libdbi implements a database-independent abstraction layer in C, similar to the DBI/DBD layer in Perl."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdbi.sourceforge.net/"
LICENSE="LGPL-2.1"
RDEPEND=""
DEPEND=">=sys-apps/sed-4
		dev-util/pkgconfig
		doc? ( app-text/openjade )
		${RDEPEND}"
PDEPEND=">=dev-db/libdbi-drivers-0.8.3" # On purpose, libdbi-drivers 0.8.4 does not exist
IUSE="doc"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
SLOT=0

src_unpack() {
	unpack ${A}
	chown -R portage:portage "${S}"
}

src_prepare() {
	epatch "${FILESDIR}"/libdbi-0.8.1-pkg-config.patch
	cp -f "${FILESDIR}"/dbi.pc.in "${S}"/dbi.pc.in
	epatch "${FILESDIR}"/libdbi-0.8.4-doc-build-fix.patch

	# configure.in has been changed
	eautoreconf || die "eautoreconf failed"
	# should append CFLAGS, not replace them
	sed -i.orig -e 's/^CFLAGS = /CFLAGS += /g' src/Makefile.in
}

src_configure() {
	econf $(use_enable doc docs) || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${ED}" || die "make install failed"
	dodoc AUTHORS ChangeLog README README.osx TODO

	# syslog-ng requires dbi.pc
	insinto /usr/$(get_libdir)/pkgconfig/
	doins dbi.pc
}
