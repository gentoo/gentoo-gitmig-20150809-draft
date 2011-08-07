# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.10.9.ebuild,v 1.6 2011/08/07 17:35:31 armin76 Exp $

inherit autotools

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/clpbar/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="doc? ( >=app-doc/doxygen-1.3.5 )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e '/^LDFLAGS/d' \
		-e '/cd $(WEB_DIR) && $(MAKE)/d' -i Makefile.am || die
	eautomake
}

src_compile() {
	local myconf

	# Fix wrt #113392
	use sparc && myconf="${myconf} --disable-use-memalign"
	econf ${myconf}

	emake CFLAGS="${CFLAGS}" || die "emake failed"
	if use doc; then
		mkdir -p ../www/doxygen/${PV}
		emake update-web || die "make doc failed" ;
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO TROUBLESHOOTING debian/changelog || die "dodoc failed"
	newdoc ChangeLog ChangeLog.old || die
	if use doc ; then
		dohtml -r ../www/doxygen/${PV}/html/*
	fi
}
