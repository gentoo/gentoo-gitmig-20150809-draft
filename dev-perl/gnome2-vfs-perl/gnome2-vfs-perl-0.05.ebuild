# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-0.05.ebuild,v 1.5 2004/07/14 17:41:08 agriffis Exp $

inherit perl-module

MY_P=Gnome2-VFS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome  VIrtual File System libraries."
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha hppa ~amd64"
IUSE=""

DEPEND="dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	>=gnome-base/gnome-vfs-2
	dev-perl/glib-perl
	dev-perl/gtk2-perl"

src_compile() {
	cp -f ${FILESDIR}/vfs.typemap ${S}/
	perl-module_src_compile
}
