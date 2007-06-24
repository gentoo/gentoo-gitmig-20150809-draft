# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/thread/thread-2.6.2.ebuild,v 1.13 2007/06/24 23:29:15 vapier Exp $

inherit autotools eutils multilib

DESCRIPTION="the Tcl Thread extension"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="gdbm"

DEPEND="gdbm? ( sys-libs/gdbm )
	dev-lang/tcl"

S=${WORKDIR}/${PN}${PV}

RESTRICT="test"

pkg_setup() {
	if ! built_with_use dev-lang/tcl threads ; then
		eerror "dev-lang/tcl was not merged with threading enabled."
		eerror "please re-emerge dev-lang/tcl with USE=threads"
		die "threading not enabled in dev-lang/tcl"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Search for libs in libdir not just exec_prefix/lib
	sed -i -e 's:${exec_prefix}/lib:${libdir}:' \
		aclocal.m4 || die "sed failed"

	sed -i -e "s/relid'/relid/" tclconfig/tcl.m4

	eaclocal
	eautoconf
}

src_compile() {
	econf \
		--with-threads \
		--with-tclinclude=/usr/include \
		--with-tcl="/usr/$(get_libdir)" \
		$(use_with gdbm) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
