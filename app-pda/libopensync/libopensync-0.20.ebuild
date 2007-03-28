# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.20.ebuild,v 1.6 2007/03/28 20:32:29 peper Exp $

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug doc python"
#test
#profiling" - needs tau - http://www.cs.uoregon.edu/research/tau/


RDEPEND=">=dev-db/sqlite-3
	>=dev-libs/glib-2
	dev-libs/libxml2
	python? ( >=dev-lang/python-2.2
		>=dev-lang/swig-1.3.17 )
	debug? ( >=dev-libs/check-0.9.2 ) "
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	doc? ( app-doc/doxygen )"

# Tests are still broken in 0.20
RESTRICT="test"

src_compile() {
		#$(use_enable test unit-tests) \
	econf \
		--enable-engine \
		--enable-tools \
		$(use_enable python) \
		$(use_enable debug) \
		$(use_enable debug tracing) \
		|| die "econf failed"

	emake || die "emake failed"

	use doc && doxygen Doxyfile
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml docs/html/*
}
