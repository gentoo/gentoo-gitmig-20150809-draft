# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.4_pre3.ebuild,v 1.2 2003/03/14 10:17:33 seemant Exp $

MY_P=${P/_}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"
DESCRIPTION=" Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc 
	virtual/x11
	nls? ( sys-devel/gettext )"
     
#RDEPEND=""

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die 
	prepalldocs
}
