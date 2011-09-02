# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcs/libmcs-0.7.2.ebuild,v 1.1 2011/09/02 09:49:56 chainsaw Exp $

EAPI=4

DESCRIPTION="Abstracts the storage of configuration settings away from applications."
HOMEPAGE="http://git.atheme.org/libmcs/"
SRC_URI="http://distfiles.atheme.org/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="gnome"

RDEPEND=">=dev-libs/libmowgli-0.6.1
	gnome? ( >=gnome-base/gconf-2.6.0 )"
DEPEND=">=dev-util/pkgconfig-0.9.0
	${RDEPEND}"

src_configure() {
	econf \
		--disable-kconfig \
		$(use_enable gnome gconf)
}

src_install() {
	default
	dodoc AUTHORS README TODO
}
