# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/thread/thread-2.6.2.ebuild,v 1.15 2009/08/14 00:45:12 fauli Exp $

EAPI=2

inherit autotools eutils multilib

DESCRIPTION="the Tcl Thread extension"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="gdbm"

DEPEND="gdbm? ( sys-libs/gdbm )
	dev-lang/tcl[threads]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}${PV}

RESTRICT="test"

src_prepare() {
	# Search for libs in libdir not just exec_prefix/lib
	sed -i -e 's:${exec_prefix}/lib:${libdir}:' \
		aclocal.m4 || die "sed failed"

	sed -i -e "s/relid'/relid/" tclconfig/tcl.m4

	eaclocal
	eautoconf
}

src_configure() {
	local use_gdbm=""
	if use gdbm; then use_gdbm="--with-gdbm"; fi
	econf \
		--with-threads \
		--with-tclinclude=/usr/include \
		--with-tcl="/usr/$(get_libdir)" \
		${use_gdbm} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
