# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-1.7.26.ebuild,v 1.5 2005/01/28 22:02:08 hansmi Exp $

inherit gcc eutils gnuconfig

DESCRIPTION="C++ API interface to the MySQL database"
# This is the download page but includes links to other places
HOMEPAGE="http://www.mysql.org/downloads/api-mysql++.html"
SRC_URI="http://www.tangentsoft.net/mysql++/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~hppa ~mips sparc ppc ~amd64"
IUSE=""

DEPEND=">=dev-db/mysql-4.0
		>=sys-devel/gcc-3"

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	gnuconfig_update
	local myconf
	# we want C++ exceptions turned on
	myconf="--enable-exceptions"
	# We do this because of the large number of header files installed to
	# the include directory
	# This is a breakage compared to previous versions that installed
	# straight to /usr/include
	myconf="${myconf} --includedir=/usr/include/mysql++"
	# not including the directives to where MySQL is because it seems to
	# find it just fine without

	# force the cflags into place otherwise they get totally ignored by
	# configure
	CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	econf ${myconf} || die "econf failed"

	emake || die "unable to make"
}

src_install() {
	make DESTDIR=${D} install || die
	# install the docs and HTML pages
	dodoc README LGPL
	dodoc doc/*
	dohtml doc/man-html/*
	prepalldocs
	warning_movedir
}

pkg_postinst() {
	warning_movedir
}

warning_movedir() {
	ewarn "The MySQL++ include directory has changed compared to previous"
	ewarn "versions.  It was previously /usr/include, but now it is"
	ewarn "/usr/include/mysql++"
}


