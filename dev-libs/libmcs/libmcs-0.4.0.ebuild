# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcs/libmcs-0.4.0.ebuild,v 1.1 2007/02/27 09:58:57 chainsaw Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Abstracts the storage of configuration settings away from userland applications."
HOMEPAGE="http://sacredspiral.co.uk/~nenolod/mcs/"
SRC_URI="http://sacredspiral.co.uk/~nenolod/mcs/${MY_P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome kde"

RDEPEND="gnome? ( >=gnome-base/gconf-2.6.0 )
	 kde? ( kde-base/kdelibs )"

src_compile() {
	econf \
		$(use_enable gnome gconf) \
		$(use_enable kde kconfig) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
}
