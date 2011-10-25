# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-user-dirs/xdg-user-dirs-0.14.ebuild,v 1.5 2011/10/25 12:06:27 jer Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="A tool to help manage 'well known' user directories"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/xdg-user-dirs"
SRC_URI="http://user-dirs.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	epatch "${FILESDIR}"/${P}-strndup-nls.patch
	eautoreconf # for the above patch
}

src_configure() {
	econf $(use_enable nls)
}
