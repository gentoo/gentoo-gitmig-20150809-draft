# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.9.2.ebuild,v 1.5 2004/10/22 01:54:52 weeve Exp $

inherit kde

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
SRC_URI="http://www.periapsis.org/${PN}/download/${P}.tar.gz"

KEYWORDS="x86 sparc ~amd64 ppc"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19"
need-kde 3.1


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

