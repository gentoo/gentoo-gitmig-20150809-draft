# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ebuilded/ebuilded-0.1.0.ebuild,v 1.1 2002/06/10 08:00:20 stroke Exp $

S=${WORKDIR}/${P}

DESCRIPTION="ebuilded: A GTK+ ebuilds editor."
SRC_URI="http://www.gentoo.org/~stroke/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.org/~stroke/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	nls? ( sys-devel/gettext )"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

	
src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "configure failed"

	emake || die "emake failed"
}



src_install () {
	local myinst
	myinst="prefix=${D}/usr"

	einstall ${myinst} || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
