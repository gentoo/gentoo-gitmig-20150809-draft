# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-3.3.2.ebuild,v 1.4 2006/04/22 11:35:09 carlo Exp $

inherit kde eutils

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."
HOMEPAGE="http://www.kdevelop.org"
#SRC_URI="mirror://kde/stable/${PV/#3.3/3.5}/src/${P}.tar.bz2"
SRC_URI="mirror://kde/stable/${PV/3.3/3.5}/src/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ada clearcase cvs fortran haskell java pascal perforce perl php python ruby sql subversion"

DEPEND="sys-devel/gdb
	=sys-libs/db-4.1*
	cvs? ( || ( kde-base/cervisia kde-base/kdesdk ) )"
RDEPEND="${DEPEND}
	subversion? ( || ( kde-base/kdesdk-kioslaves kde-base/kdesdk ) )"
DEPEND="${DEPEND}
	sys-devel/flex"
need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Update the admin dir used in KDE template projects.
	# See also kde bug 104386.
	for i in ${S}/admin/*; do
		cp "${i}" "${S}/parts/appwizard/common/admin/"
	done
}

src_compile() {
	local myconf="--with-kdelibsdoxy-dir=$(kde-config --prefix)/share/doc/HTML/en/kdelibs-apidocs"

	# languages
	myconf="${myconf} $(use_enable java) $(use_enable python)
			$(use_enable ruby) $(use_enable ada) $(use_enable fortran)
			$(use_enable haskell) $(use_enable pascal) $(use_enable perl)
			$(use_enable php) $(use_enable sql)"

	# build tools
	myconf="${myconf} $(use_enable java antproject)"

	# version control systems
	myconf="${myconf} $(use_enable cvs) $(use_enable clearcase) $(use_enable perforce)
			$(use_enable subversion)"

	# Explicitly set db include directory (bug 128897)
	myconf="${myconf} --with-db-includedir=${ROOT}/usr/include/db4.1 --with-db-lib=db-4.1"

	kde_src_compile
}

pkg_postinst() {
	einfo "kdevelop can use a wide range of apps for extra functionality. This is an almost"
	einfo "complete list. All these packages can be emerged after kdevelop."
	einfo
	einfo "kde-base/kdebase:               (RECOMMENDED) embed konsole kpart in kdevelop ide"
	einfo "dev-util/kdbg:                  (RECOMMENDED) kde frontend to gdb"
	einfo "dev-util/valgrind:              (RECOMMENDED) integrates valgrind (memory debugger) commands"
	einfo "kde-base/kompare:               (RECOMMENDED) show differences between files"
	einfo "dev-java/ant:                   support projects using the ant build tool"
	einfo "dev-util/ctags:                 faster and more powerful code browsing logic"
	einfo "app-doc/doxygen:                generate KDE-style documentation for your project"
	einfo "www-misc/htdig:                  index and search your project's documentation"
	einfo "app-arch/rpm:                   support creating RPMs of your project"
	einfo "app-emulation/visualboyadvance: create and run projects for this gameboy"
	einfo
	einfo "Support for GNU-style make, tmake, qmake is included."
	einfo "Support for using clearcase, perforce and subversion"
	einfo "as version control systems is optional."
}
