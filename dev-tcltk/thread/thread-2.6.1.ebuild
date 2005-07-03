# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/thread/thread-2.6.1.ebuild,v 1.2 2005/07/03 01:20:12 matsuu Exp $

inherit eutils

DESCRIPTION="the Tcl Thread extension"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gdbm"

DEPEND="gdbm? ( sys-libs/gdbm )
	>=dev-lang/tcl-8.4"

S=${WORKDIR}/${PN}${PV}

pkg_setup() {
	if ! built_with_use dev-lang/tcl threads ; then
		eerror "dev-lang/tcl was not merged with threading enabled."
		eerror "please re-emerge dev-lang/tcl with USE=threads"
		die "threading not enabled in dev-lang/tcl"
	fi
}

src_compile() {
	local myconf="--with-threads --with-tclinclude=/usr/include"

	if use gdbm ; then
		myconf="${myconf} --with-gdbm"
	fi
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README
}
