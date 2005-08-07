# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glimmer/glimmer-1.2.1-r5.ebuild,v 1.9 2005/08/07 13:01:49 hansmi Exp $

inherit flag-o-matic

IUSE="python"

DESCRIPTION="All-purpose gnome code editor."
SRC_URI="mirror://sourceforge/glimmer/${P}.tar.gz"
HOMEPAGE="http://glimmer.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"

DEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-vfs-1*
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/orbit-0*
	>=gnome-base/gnome-print-0.35
	python? ( virtual/python
		<dev-python/gnome-python-1.99 )"

src_compile() {
	replace-flags "-O3" "-O2"
	local myconf

	use python || myconf="--disable-python"

	#disable nls for sandbox issues
	econf --disable-nls ${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ABOUT-NLS ChangeLog NEWS PROPS TODO README INSTALL COPYING
}
