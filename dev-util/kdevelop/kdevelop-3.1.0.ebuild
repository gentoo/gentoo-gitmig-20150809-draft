# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-3.1.0.ebuild,v 1.5 2004/09/03 14:11:19 caleb Exp $

inherit python kde eutils

MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}

IUSE="arts doc java python ruby"
DESCRIPTION="KDevelop is an easy to use C/C++ IDE for Unix. It supports KDE/Qt, GNOME, plain C and C++ projects."
SRC_URI="mirror://kde/stable/3.3/src/${MY_P}.tar.bz2"
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
RDEPEND="$DEPEND"
need-kde 3.2

myconf="$myconf --with-kdelibsdoxy-dir=${KDEDIR}/share/doc/HTML/en/kdelibs-apidocs"

src_unpack() {
	kde_src_unpack

	# fPIC patches shall be applied unconditionally
	# BUG #55238
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	epatch ${FILESDIR}/${P/.0/_beta1}-bdb-fPIC.patch

	if use amd64; then
		epatch ${FILESDIR}/${P}-bdb-mutex.patch
	fi
}

src_compile() {
	python_version
	myconf="$myconf $(use_enable java javasupport) $(use_with java java $(java-config --jdk-home))
			$(use_enable python scripting) $(use_with python pythondir /usr/lib/python${PYVER})
			$(use_enable ruby)
			$(use_with arts)"
	kde_src_compile
}

pkg_postinst() {

einfo "kdevelop can use a wide range of apps for extra functionality. This is an almost"
einfo "complete list. If you want subversion support, you must emerge it and then re-emerge"
einfo "kdevelop; all other packages can be emerged after kdevelop."
einfo
einfo "dev-util/cvs:		provide frontend for cvs version control system"
einfo "net-misc/x11-ssh-askpass		for use with SSH protected CVS systems"
einfo "dev-util/subversion		ditto for subversion."
einfo ">=dev-util/ctags-5		faster and more powerful code browsing logic"
einfo "dev-util/kdoc		tools to generate KDE-style documentation for your project"
einfo "app-misc/glimpse		index and search your project's documentation"
einfo "net-www/htdig		ditto. yet another supported indexing/searching backend"
einfo "dev-util/kdbg		kde frontend to gdb"
einfo "app-arch/rpm			supports creating RPMs of your project"
einfo "kde-base/kdebase		embed konsole kpart in kdevelop ide"
einfo "kde-base/kdesdk		use kompare widget for showing the output of diff"
einfo "dev-util/valgrind		integrates valgrind (memory debugger) commands"
einfo "app-emulation/		create and run projects for this gameboy"
einfo "	visualboyadvance	/gameboy color/gameboy advance emulator"
einfo
einfo "Support for GNU-style make, tmake, qmake and probably jam and other systems is included."
einfo "There is also php, fortran, etc. support - use your favourite package, I suppose."

}

