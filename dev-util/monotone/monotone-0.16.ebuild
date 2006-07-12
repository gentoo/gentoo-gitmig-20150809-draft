# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.16.ebuild,v 1.6 2006/07/12 14:13:21 kugelfang Exp $

inherit eutils flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/monotone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
#Target Keywords  ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

IUSE="nls doc"

RDEPEND=">=dev-libs/boost-1.31.0
	dev-libs/popt"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	sys-devel/gettext
	doc? ( dev-lang/perl sys-apps/texinfo )"

src_compile() {

	# more aggressive optimizations cause trouble with the
	# crypto library
	# disable stack protector

	strip-flags
	# replace-flags -O3 -O2
	append-flags -fno-stack-protector-all -fno-stack-protector -fno-strict-aliasing

	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_test() {
	make check
	einfo "test may fail on test 62"
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Generate html docs

	#if use doc ; then
	#	emake html || die "emake html failed"
	#	dohtml -r html/*
	#fi

	dodoc NEWS
}
