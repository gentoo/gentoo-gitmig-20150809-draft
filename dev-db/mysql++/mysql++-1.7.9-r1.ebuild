# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-1.7.9-r1.ebuild,v 1.4 2003/05/11 18:14:07 robbat2 Exp $

S=${WORKDIR}/${P}

DESCRIPTION="C++ API interface to the MySQL database"

SRC_URI="http://mysql.he.net/Downloads/${PN}/${P}.tar.gz
	http://mysql.adgrafix.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.fastmirror.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.oms-net.nl/Downloads/${PN}/${P}.tar.gz
	mirror://gentoo/mysql++-gcc-3.0.patch.gz
	mirror://gentoo/mysql++-gcc-3.2.patch.gz"

# This is the download page but includes links to other places
HOMEPAGE="http://www.mysql.org/downloads/api-mysql++.html"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~alpha ~hppa ~mips ~arm ~sparc ~ppc"
LICENSE="LGPL-2"
DEPEND=">=dev-db/mysql-3.23.49"

src_unpack() {
	unpack "${A}"
	EPATCH_OPTS="-p1 -d ${S}"
	if [[ "${COMPILER}" == "gcc3" ]];then
		EPATCH_SINGLE_MSG="Patching for gcc 3.0..."
		epatch ${DISTDIR}/mysql++-gcc-3.0.patch.gz
		EPATCH_SINGLE_MSG="Patching for gcc 3.2..."
		epatch ${DISTDIR}/mysql++-gcc-3.2.patch.gz
		EPATCH_SINGLE_MSG="Patching to fix some warnings and errors..."
		epatch ${FILESDIR}/mysql++-1.7.9-gcc_throw.patch
		EPATCH_SINGLE_MSG="Patch for const char* error"
		epatch ${FILESDIR}/mysql++-1.7.9-mysql4-gcc3.patch	
	else
		EPATCH_SINGLE_MSG="Patch for const char* error"
		epatch ${FILESDIR}/mysql++-1.7.9-mysql4-gcc295.patch	
	fi
	EPATCH_SINGLE_MSG="Fixing examples directory bug..."
	epatch ${FILESDIR}/mysql++-1.7.9_example.patch
}

src_compile() {

	local myconf
	# we want C++ exceptions turned on
	myconf="--enable-exceptions"
	# We do this because of the large number of header files installed to the include directory
	# This is a breakage compared to previous versions that installed straight to /usr/include
	myconf="${myconf} --includedir=/usr/include/mysql++"
	# not including the directives to where MySQL is because it seems to find it
	# just fine without
	# force the cflags into place otherwise they get totally ignored by configure
	CFLAGS="${CFLAGS}" CXXFLAGS="${CFLAGS} ${CXXFLAGS}" \
	econf \
		--enable-exceptions \
		--includedir=/usr/include/mysql++ 

	emake || die "unable to make"
}

src_install () {
	make DESTDIR=${D} install || die
	# install the docs and HTML pages
	dodoc README LGPL
	dodoc doc/*
	dohtml doc/man-html/*
	prepalldocs
	ewarn "The MySQL++ include directory has changed compared to previous versions"
	ewarn "It was previously /usr/include, but now it is /usr/include/mysql++"
}

pkg_postinst() {
	ewarn "The MySQL++ include directory has changed compared to previous versions"
	ewarn "It was previously /usr/include, but now it is /usr/include/mysql++"
}
