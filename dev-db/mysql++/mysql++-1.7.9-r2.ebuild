# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-1.7.9-r2.ebuild,v 1.2 2003/09/06 22:25:50 msterret Exp $

inherit gcc eutils

DESCRIPTION="C++ API interface to the MySQL database"
# This is the download page but includes links to other places
HOMEPAGE="http://www.mysql.org/downloads/api-mysql++.html"
SRC_URI_BASE="mirror://mysql/Downloads/${PN}"
SRC_URI="
	${SRC_URI_BASE}/${P}.tar.gz
	${SRC_URI_BASE}/${PN}-gcc-3.0.patch.gz
	${SRC_URI_BASE}/${PN}-gcc-3.2.patch.gz
	${SRC_URI_BASE}/${PN}-gcc-3.2.2.patch.gz
	${SRC_URI_BASE}/patch_gcc_3.3.gz
	${SRC_URI_BASE}/mysqlplus-gcc-3.4.patch.gz
	"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~hppa ~mips ~arm ~sparc ~ppc"

DEPEND=">=dev-db/mysql-3.23.49"

src_unpack() {
	unpack ${P}.tar.gz
	EPATCH_OPTS="-p1 -d ${S}"
	if [ `gcc-major-version` -eq 3 ] ; then
		EPATCH_SINGLE_MSG="Patching for gcc 3.0..." \
		epatch ${DISTDIR}/mysql++-gcc-3.0.patch.gz
		if [ `gcc-minor-version` -eq 2 ] ; then
			EPATCH_SINGLE_MSG="Patching for gcc 3.2..." \
			epatch ${DISTDIR}/mysql++-gcc-3.2.patch.gz
			if [ `gcc-micro-version` -ge 2 ] ; then
				EPATCH_SINGLE_MSG="Patching for gcc >=3.2.2..." \
				epatch ${DISTDIR}/mysql++-gcc-3.2.2.patch.gz
			fi
		elif [ `gcc-minor-version` -eq 3 ] ; then
			EPATCH_SINGLE_MSG="Patching for gcc 3.3..." \
			epatch ${DISTDIR}/patch_gcc_3.3.gz
		elif [ `gcc-minor-version` -eq 4 ] ; then
			EPATCH_SINGLE_MSG="Patching for gcc 3.4 (patch for 3.2 needed first)..." \
			epatch ${DISTDIR}/mysql++-gcc-3.2.patch.gz
			EPATCH_SINGLE_MSG="Patching for gcc 3.4..." \
			epatch ${DISTDIR}/mysqlplus-gcc-3.4.patch.gz
		fi
		EPATCH_SINGLE_MSG="Patching to fix some warnings and errors..." \
		epatch ${FILESDIR}/mysql++-1.7.9-gcc_throw.patch
		# This is included in mysql++-gcc-3.2.2.patch.gz
		#EPATCH_SINGLE_MSG="Patch for const char* error" \
		#epatch ${FILESDIR}/mysql++-1.7.9-mysql4-gcc3.patch
	else
		EPATCH_SINGLE_MSG="Patch for const char* error" \
		epatch ${FILESDIR}/mysql++-1.7.9-mysql4-gcc295.patch
	fi
	EPATCH_SINGLE_MSG="Fixing examples directory bug..." \
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

src_install() {
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
