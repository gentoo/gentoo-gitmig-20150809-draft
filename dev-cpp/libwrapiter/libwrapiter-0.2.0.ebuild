# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libwrapiter/libwrapiter-0.2.0.ebuild,v 1.7 2006/09/01 10:27:11 killerfox Exp $

DESCRIPTION="C++ template library for avoiding exposing privates via iterators"
HOMEPAGE="http://libwrapiter.berlios.de/"
SRC_URI="http://download.berlios.de/libwrapiter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="
	>=sys-devel/autoconf-2.59
	=sys-devel/automake-1.9*
	doc? ( app-doc/doxygen )"

RDEPEND=""

ESVN_REPO_URI="svn://svn.berlios.de/libwrapiter/trunk"
ESVN_BOOTSTRAP="./autogen.bash"

src_compile() {
	econf \
		$(use_enable doc doxygen ) \
		|| die "econf failed"

	emake || die "emake failed"
	if use doc ; then
		make doxygen || die "make doxygen failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README ChangeLog NEWS

	if use doc ; then
		dohtml -V -r doc/html/
	fi
}

src_test() {
	emake check || die "Make check failed"
}

