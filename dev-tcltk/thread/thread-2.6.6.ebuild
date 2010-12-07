# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/thread/thread-2.6.6.ebuild,v 1.1 2010/12/07 13:40:28 jlec Exp $

EAPI=2

inherit autotools eutils multilib

DESCRIPTION="Tcl Thread extension"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gdbm"

DEPEND="
	dev-lang/tcl[threads]
	gdbm? ( sys-libs/gdbm )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}${PV}

RESTRICT="test"

src_prepare() {
	# Search for libs in libdir not just exec_prefix/lib
	sed -i -e 's:${exec_prefix}/lib:${libdir}:' \
		aclocal.m4 || die "sed failed"

	sed -i -e "s/relid'/relid/" tclconfig/tcl.m4

	eautoreconf
}

src_configure() {
	econf \
		--with-tclinclude=/usr/include \
		--with-tcl="/usr/$(get_libdir)" \
		$(use_with gdbm) \
		$(use_enable debug symbols)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README || die
}
