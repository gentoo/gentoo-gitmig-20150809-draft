# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libghttp/libghttp-1.0.9-r4.ebuild,v 1.1 2003/12/07 16:28:54 foser Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit libtool gnome.org

DESCRIPTION="GNOME http client library"
LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fixes http locale related bug (#33386)
	epatch ${FILESDIR}/${P}-fixlocale.patch

}

src_compile() {

	elibtoolize

	econf || die
	emake || die

}

src_install() {
	einstall || die

	# headers needed for Intermezzo (bug 11501)
	insinto /usr/include/ghttp-1.0/
	doins http*.h

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	dohtml doc/*.html
}
