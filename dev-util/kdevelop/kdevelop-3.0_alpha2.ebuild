# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-3.0_alpha2.ebuild,v 1.6 2003/03/11 21:11:45 seemant Exp $

inherit kde-base
need-kde 3

IUSE=""
MY_P="kdevelop-3.0a2"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="KDevelop is an easy to use C/C++ IDE for Unix. It supports KDE/Qt, GNOME, plain C and C++ projects."
SRC_URI="mirror://kde/unstable/${P/_/-}/src/${MY_P}.tar.bz2"
HOMEPAGE="http://www.kdevelop.org"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT=3
# -j2 and greater fails - see bug #6199
export MAKEOPTS="$MAKEOPTS -j1"

newdepend ">=dev-lang/perl-5.0.4
	sys-devel/flex
	app-text/sgmltools-lite
	app-misc/glimpse
	dev-util/kdoc
	>=app-text/a2ps-4.11
	app-text/enscript
	net-www/htdig
	dev-util/kdbg
	sys-devel/gdb
	app-text/ghostview
	dev-util/cvs
	>=dev-util/ctags-5
	app-doc/qt-docs
	app-doc/kdelibs-apidocs"

src_unpack() {
	unpack ${A}
	cd ${S}
	cat ${FILESDIR}/${P}-gentoo.diff.bz2 | bzip2 -d | patch -p0
	patch -p0 < ${FILESDIR}/${P}-kde-3.0.5a.diff
}
