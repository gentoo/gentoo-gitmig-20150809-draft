# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.8.5.ebuild,v 1.2 2004/03/21 18:31:28 weeve Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
LICENSE="GPL-2"
SRC_URI="http://www.periapsis.org/${PN}/download/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""


newdepend ">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19"



src_compile() {
	myconf="${myconf} --disable-debug --enable-final"
	# The package does not want to build without the 
	#	--disable-debug: since fileappfinder uses an undefined 
	#		kbDebug function
	#	--enable-final: I do not know the reason for build 
	# 		without this function. Looked at the *.spec (RPM)
	#		at the ${HOMEPAGE}
	# This *.spec file requires also the ImageMagick package. 

	# Build process of bookcase
	kde_src_compile
}

src_install() {
	make DESTDIR=${D} install || or die

	# install some extra docs not included in make install's targets
	dodoc AUTHORS TODO ChangeLog
}

