# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.15.ebuild,v 1.1 2004/12/30 04:35:47 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/monotone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
#Target Keywords  ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

IUSE="nls"
# "doc"

RDEPEND="virtual/libc
	>=dev-libs/boost-1.31.0
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3.3
	sys-devel/gettext"
#	doc? ( dev-lang/perl sys-apps/texinfo )"

src_compile() {

	# more aggressive optimizations cause trouble with the
	# crypto library
	# disable stack protector

	replace-flags -O3 -O2
	append-flags -fno-stack-protector-all -fno-stack-protector

	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_test() {
	einfo "self test currently broken"
}

src_install() {
	emake DESTDIR=${D} install || die

	# Generate html docs

	#if use doc ; then
	#	emake html || die "emake html failed"
	#	dohtml -r html/*
	#fi

	dodoc NEWS
}
