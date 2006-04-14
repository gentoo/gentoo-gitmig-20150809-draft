# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libodbc++/libodbc++-0.2.3-r1.ebuild,v 1.3 2006/04/14 00:07:27 halcy0n Exp $

inherit eutils

DESCRIPTION="Libodbc++ is a c++ class library that provides a subset of the well-known JDBC 2.0(tm) and runs on top of ODBC."
SRC_URI="mirror://sourceforge/libodbcxx/${P}.tar.gz"
HOMEPAGE="http://libodbcxx.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND="dev-db/unixODBC
		sys-libs/libtermcap-compat"
KEYWORDS="~x86 ~ppc ~hppa ~alpha ~amd64"
IUSE="qt"
SLOT=0

SB="${S}-build"
SB_MT="${S}-build-mt"
SB_QT="${S}-build_qt"
SB_QT_MT="${S}-build_qt-mt"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-std-streamsize.patch
	epatch "${FILESDIR}"/${P}-doxygen.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	local commonconf
	commonconf="--with-odbc=/usr --without-tests"
	commonconf="${commonconf} --enable-static --enable-shared"
	# " --enable-threads"
	if ! has ccache FEATURES; then
		einfo "ccache would really help you compiling this package..."
	fi

	export ECONF_SOURCE="${S}"
	append-flags -DODBCXX_DISABLE_READLINE_HACK

	buildlist="${SB} ${SB_MT}"
	use qt && buildlist="${buildlist} $SB_QT $SB_QT_MT"

	for sd in ${buildlist}; do
		mkdir -p "${sd}"
		cd "${sd}"
		commonconf2=''
		LIBS=''
		[ "${sd}" == "${SB_MT}" -o "${sd}" == "${SB_QT_MT}" ] && commonconf2="${commonconf2} --enable-threads"
		[ "${sd}" == "${SB_QT}" -o "${sd}" == "${SB_QT_MT}" ] && commonconf2="${commonconf2} --with-qt"
		[ "${sd}" == "${SB}" ] && commonconf2="${commonconf2} --with-isqlxx"
		[ "${sd}" == "${SB_QT}" ] && commonconf2="${commonconf2} --with-qtsqlxx"
		export LIBS
		# using without-qt breaks the build
		#--without-qt \
		econf \
			${commonconf} \
			${commonconf2} \
			|| die "econf failed"
		emake || die "emake failed"
	done
}

src_install () {
	cd ${S}
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO

	buildlist="${SB} ${SB_MT}"
	use qt && buildlist="${buildlist} $SB_QT $SB_QT_MT"
	for sd in ${buildlist}; do
		cd ${sd}
		make DESTDIR=${D} install || die "make install failed"
	done
}
