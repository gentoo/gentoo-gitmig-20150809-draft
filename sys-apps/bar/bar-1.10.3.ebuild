# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.10.3.ebuild,v 1.5 2006/02/12 19:50:54 deltacow Exp $

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/clpbar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc x86"
IUSE="doc"

DEPEND="doc? ( >=app-doc/doxygen-1.3.5 )"
RDEPEND=""

src_compile() {
	local myconf

	# Fix wrt #113392
	use sparc && myconf="${myconf} --disable-use-memalign"
	econf ${myconf} || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	use doc && { emake doc || die "make doc failed" ; }
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL PORTING ChangeLog || die "dodoc failed"
	if use doc ; then
		rm -f ${S}/doc/html/installdox
		cp -R ${S}/doc/html ${D}/usr/share/doc/${PF}/
	fi
}
