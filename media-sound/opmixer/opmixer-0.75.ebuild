# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/opmixer/opmixer-0.75.ebuild,v 1.2 2002/07/21 13:50:33 seemant Exp $

MY_P=${P/opm/opM}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An oss mixer written in c++ using the gtkmm gui-toolkit. Supports saving, loading and muting of volumes for channels and autoloading via a consoleapp"
HOMEPAGE="http://optronic.sourceforge.net/"
SRC_URI="http://optronic.sourceforge.net/files/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


DEPEND="=x11-libs/gtk+-1.2*
	>=x11-libs/gtkmm-1.2.2"

RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
