# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-3.2.0_beta1.ebuild,v 1.1 2005/01/14 00:21:36 greg_g Exp $

inherit python kde eutils

MY_PV=3.1.91
S=${WORKDIR}/${PN}-${MY_PV}

IUSE="doc java python ruby"
DESCRIPTION="KDevelop is an easy to use C/C++ IDE for Unix. It supports KDE/Qt, GNOME, plain C and C++ projects."
SRC_URI="mirror://kde/unstable/${MY_PV/#3.1/3.3}/src/${PN}-${MY_PV}.tar.bz2"
HOMEPAGE="http://www.kdevelop.org"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT=3

DEPEND="dev-lang/perl
	sys-devel/flex
	sys-devel/gdb
	java? ( virtual/jdk dev-java/ant dev-java/java-config )
	python? ( dev-lang/python )
	doc? ( app-doc/doxygen )"

need-kde 3.3

src_compile() {
	python_version

	myconf="$myconf --with-kdelibsdoxy-dir=${KDEDIR}/share/doc/HTML/en/kdelibs-apidocs"
	myconf="$myconf $(use_enable java javasupport) $(use_with java java $(java-config --jdk-home))
			$(use_enable python scripting) $(use_with python pythondir /usr/lib/python${PYVER})
			$(use_enable ruby)"
	kde_src_compile
}

pkg_postinst() {

einfo "kdevelop can use a wide range of apps for extra functionality. This is an almost"
einfo "complete list. If you want subversion support, you must emerge it and then re-emerge"
einfo "kdevelop; all other packages can be emerged after kdevelop."
einfo
einfo "kde-base/kdebase:			(RECOMMENDED) embed konsole kpart in kdevelop ide"
einfo "kde-base/kdesdk:				(RECOMMENDED) use kompare widget for showing the output of diff, cvs support"
einfo "dev-util/kdbg:				(RECOMMENDED) kde frontend to gdb"
einfo "dev-util/valgind:			(RECOMMENDED) integrates valgrind (memory debugger) commands"
einfo "dev-util/cvs dev-util/subversion:	provide frontend for cvs version control system"
einfo ">=dev-util/ctags-5:			faster and more powerful code browsing logic"
einfo "app-doc/doxygen:				generate KDE-style documentation for your project"
einfo "app-misc/glimpse:			index and search your project's documentation"
einfo "net-www/htdig:				ditto. yet another supported indexing/searching backend"
einfo "app-arch/rpm:				supports creating RPMs of your project"
einfo "app-emulation/visualboyadvance		create and run projects for this gameboy"
einfo
einfo "Support for GNU-style make, tmake, qmake and probably jam and other systems is included."
einfo "There is also php, fortran, etc. support - use your favourite package, I suppose."

}
