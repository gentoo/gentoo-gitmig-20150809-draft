# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libwrapiter/libwrapiter-1.2.0.ebuild,v 1.1 2007/06/06 16:18:47 ferdy Exp $

DESCRIPTION="C++ template library for avoiding exposing privates via iterators"
HOMEPAGE="http://libwrapiter.pioto.org/"
SRC_URI="http://libwrapiter.pioto.org/download/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=sys-devel/autoconf-2.59
	=sys-devel/automake-1.10*
	doc? ( app-doc/doxygen )"
RDEPEND=""

ESVN_REPO_URI="svn://svn.pioto.org/libwrapiter/trunk"
ESVN_BOOTSTRAP="./autogen.bash"

src_compile() {
	econf \
		$(use_enable doc doxygen ) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README ChangeLog NEWS
}

src_test() {
	emake check || die "Make check failed"
}
