# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmms/libmms-0.4.ebuild,v 1.7 2009/05/07 10:11:53 jer Exp $

EAPI=2
inherit eutils

DESCRIPTION="Common library for accessing Microsoft Media Server (MMS) media streaming protocol"
HOMEPAGE="https://launchpad.net/libmms"
SRC_URI="http://launchpad.net/libmms/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-this_keyword.patch \
		"${FILESDIR}"/${P}-nested_comments.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
