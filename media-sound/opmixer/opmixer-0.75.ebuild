# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/opmixer/opmixer-0.75.ebuild,v 1.15 2004/09/15 19:39:14 eradicator Exp $

IUSE=""

MY_P=${P/opm/opM}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An oss mixer written in c++ using the gtkmm gui-toolkit. Supports saving, loading and muting of volumes for channels and autoloading via a consoleapp"
HOMEPAGE="http://optronic.sourceforge.net/"
SRC_URI="http://optronic.sourceforge.net/files/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"

src_compile() {
	econf || die

	#gcc3.2 fix for #8760
	cd ${S}/src
	cp volset.cc volset.cc.old
	sed -e 's/ endl/ std::endl/' \
		volset.cc.old > volset.cc

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
