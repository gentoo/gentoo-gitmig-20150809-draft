# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cpp/log4cpp-0.3.4b.ebuild,v 1.14 2006/10/18 16:29:48 dev-zero Exp $

KEYWORDS="x86 ppc amd64 s390"

DESCRIPTION="library of C++ classes for flexible logging to files, syslog, IDSA and other destinations"
HOMEPAGE="http://log4cpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-0.3.4b.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc threads"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}

	# We have to fix it directly in Makefile.in to avoid
	# loosing configuration-options
	cd "${S}/doc"
	sed -i \
		-e 's#$(man3dir)#$(DESTDIR)/$(man3dir)#' \
		-e 's#$(docdir)#$(DESTDIR)/$(docdir)#' \
		Makefile.in || die "sed failed"
}

src_compile() {
	econf \
		--without-omnithreads \
		--without-idsa \
		$(use_with threads pthreads) \
		$(use_enable doc doxygen) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
