# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcs/libmcs-0.2.1.ebuild,v 1.3 2007/02/03 23:03:45 jer Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Abstracts the storage of configuration settings away from userland applications."
HOMEPAGE="http://sacredspiral.co.uk/~nenolod/mcs/"
SRC_URI="http://sacredspiral.co.uk/~nenolod/mcs/${MY_P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~sparc"
IUSE="gnome"

RDEPEND="gnome? ( >=gnome-base/gconf-2.6.0 )"

src_compile() {
	econf $(use_enable gnome gconf) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
}
