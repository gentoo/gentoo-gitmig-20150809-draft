# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/opmixer/opmixer-0.75.ebuild,v 1.1 2002/07/11 22:05:13 stroke Exp $

DESCRIPTION="An oss mixer written in c++ using the gtkmm gui-toolkit. Supports saving, loading and muting of volumes for channels and autoloading via a consoleapp"
HOMEPAGE="http://optronic.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

PKGVER=`echo ${P}|cut -d \- -f2`
SRC_URI="http://optronic.sourceforge.net/files/opMixer-${PKGVER}.tar.bz2"

S="${WORKDIR}/opMixer-${PKGVER}"

DEPEND="=x11-libs/gtk+-1.2*
	>=x11-libs/gtkmm-1.2.2"

RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
