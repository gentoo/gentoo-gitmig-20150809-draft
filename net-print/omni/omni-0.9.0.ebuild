# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/omni/omni-0.9.0.ebuild,v 1.4 2003/09/07 00:18:10 msterret Exp $

DESCRIPTION="Omni provides support for many printers with a pluggable framework (easy to add devices)"
HOMEPAGE="http://sourceforge.net/projects/omniprint"
MY_P=${P/o/O}
SRC_URI="mirror://sourceforge/omniprint/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=""
RDEPEND=">=app-text/ghostscript-7.05.3-r2
	>=dev-libs/libxml-1.8.6
	dev-libs/glib
	cups? ( >=net-print/cups-1.1.14 )
	X? ( >=dev-cpp/gtkmm-1.2.5 )
	>=dev-libs/libsigc++-1.01
	foomaticdb? ( net-print/foomatic-db-engine )"

S=${WORKDIR}/Omni

IUSE="cups X ppds foomaticdb static"

src_compile() {
	use X \
		&& myconf="${myconf} --enable-jobdialog" \
		|| myconf="${myconf} --disable-jobdialog"
	use cups \
		&& myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"
	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"

	./setupOmni ${myconf} || die

	if [ "`use ppds`" -a "`use cups`" ]; then
		cd CUPS
		cp Makefile Makefile.1
		sed -e "s/model\/foomatic/model\/omni/g" Makefile.1 > Makefile

		make generateBuildPPDs || die
		cd ..
	fi
	if [ `use foomaticdb` ]; then
		cd Foomatic
		make generateFoomaticData || die
		cd ..
	fi
}

src_install () {
	make DESTDIR=${D} install || die

	if [ `use foomaticdb` ]; then
		cd Foomatic
		make DESTDIR=${D} localInstall || die
		cd ..
	fi
}
