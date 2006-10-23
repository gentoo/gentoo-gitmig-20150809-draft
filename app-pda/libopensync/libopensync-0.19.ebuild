# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.19.ebuild,v 1.1 2006/10/23 14:15:49 peper Exp $

inherit multilib

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="mirror://sourceforge/opensync/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug doc python"
#profiling" - needs tau - http://www.cs.uoregon.edu/research/tau/

DEPEND=">=dev-db/sqlite-3
	>=dev-libs/glib-2
	>=dev-util/pkgconfig-0.9.0
	python? ( >=dev-lang/python-2.2
		>=dev-lang/swig-1.3.17 )
	doc? ( app-doc/doxygen )
	debug? ( >=dev-libs/check-0.9.2 ) "
RDEPEND="${DEPEND}"

# Tests are broken in 0.19
RESTRICT="test"

src_compile() {
	# Tests are broken in 0.19
	# hasq test ${FEATURES} && CONF_TEST="--enable-unit-tests" || \
	CONF_TEST="--disable-unit-tests"
	econf ${CONF_TEST} \
		--enable-engine \
		--enable-tools \
		$(use_enable python) \
		$(use_enable debug) \
		$(use_enable debug tracing)

	emake || die "emake failed"

	# Create API docs if needed and possible
	if use doc; then
		doxygen Doxyfile
	fi
}
src_install() {
	make DESTDIR="${D}" install || die

	# Intall pkgconfig files
	insinto /usr/"$(get_libdir)"/pkgconfig
	doins *-1.0.pc

	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml docs/html/*
}
