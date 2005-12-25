# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/tinysvm/tinysvm-0.09-r1.ebuild,v 1.1 2005/12/25 17:15:25 usata Exp $

inherit perl-module flag-o-matic

MY_PN="TinySVM"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="TinySVM is an implementation of Support Vector Machines (SVMs) for
pattern recognition."
HOMEPAGE="http://chasen.org/~taku/software/TinySVM/"
SRC_URI="http://chasen.org/~taku/software/TinySVM/src/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="perl"
#IUSE="java ruby python"

DEPEND=""
#RDEPEND=""

src_compile() {
	append-ldflags -lstdc++
	econf || die
	emake || die
	if use perl ; then
		cd perl
		perl-module_src_compile || die "compile failed in perl"
		cd -
	fi
	# currently it fails to compile under python-2.4
	#if use python ; then
	#	cd python
	#	make -f Makefile.pre.in boot || die "compile failed in python"
	#	make || die
	#	cd -
	#fi
	# currently it fails to compile under gcc-3.4
	#if use ruby ; then
	#	cd ruby
	#	ruby extconf.rb || die
	#	make || die
	#	cd -
	##fi
}

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README THANKS

	if use perl ; then
		cd perl
		perl-module_src_install || die "install failed in perl"
		cd -
	fi
	#if use python ; then
	#	cd python
	#	make DESTDIR=${D} install || die "install failed in python"
	#	cd -
	#fi
	#if use ruby ; then
	#	cd ruby
	#	make DESTDIR=${D} install || die "install failed in ruby"
	#	cd -
	#fi
}
