# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libodbc++/libodbc++-0.2.3.ebuild,v 1.1 2003/11/16 11:57:27 robbat2 Exp $
S=${WORKDIR}/${P}
DESCRIPTION="Libodbc++ is a c++ class library that provides a subset of the well-known JDBC 2.0(tm) and runs on top of ODBC."
SRC_URI="mirror://sourceforge/libodbcxx/${P}.tar.gz"
HOMEPAGE="http://libodbcxx.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND="dev-db/unixODBC"
KEYWORDS="~x86 ~ppc ~hppa ~alpha amd64"
SLOT=0

src_compile() {
	local commonconf
	commonconf="--with-isqlxx --with-odbc --without-tests"
	commonconf="${commonconf} --enable-static --enable-shared"
	# " --enable-threads"

	if use qt; then
		einfo "Cloning to build with qt"
		einfo "ccache would really help you compiling this package..."
		cp -ra ${S} ${S}_qt
	fi

	econf \
		${commonconf} \
		|| die "econf failed"
	emake || die "emake failed"
	# using without-qt breaks the build
	#--without-qt \

	if use qt; then
		cd ${S}_qt
		econf \
			${commonconf} \
			--with-qtsqlxx --with-qt \
			|| die "econf failed"
		emake || die "emake failed"
	fi

}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	if use qt; then
		cd ${S}_qt
		make DESTDIR=${D} install || die "make install failed"
	fi

}
