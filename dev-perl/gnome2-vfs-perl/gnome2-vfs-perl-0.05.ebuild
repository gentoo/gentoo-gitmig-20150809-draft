# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-0.05.ebuild,v 1.1 2003/12/30 15:03:57 mcummings Exp $

inherit perl-module

MY_P=Gnome2-VFS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome  VIrtual File System libraries."
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~alpha"

DEPEND="${DEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	>=gnome-base/gnome-vfs-2
	dev-perl/glib-perl"

src_compile() {
	cp -f ${FILESDIR}/vfs.typemap ${S}/
	perl-module_src_compile
}
