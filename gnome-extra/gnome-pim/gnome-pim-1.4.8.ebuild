# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pim/gnome-pim-1.4.8.ebuild,v 1.5 2003/05/18 16:54:02 foser Exp $

IUSE="pda"

S=${WORKDIR}/${P}
DESCRIPTION="gnome-pim"
#this version is not available from official gnome repos 
SRC_URI="http://me.in-berlin.de/~jroger/gnome-pim/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/gnome-pim.shtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc "

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	pda? ( gnome-extra/gnome-pilot )"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
