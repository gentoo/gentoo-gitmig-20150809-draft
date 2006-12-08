# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pavuk/pavuk-0.9.34-r1.ebuild,v 1.5 2006/12/08 06:59:50 opfer Exp $

inherit eutils

DESCRIPTION="Web spider and website mirroring tool"
HOMEPAGE="http://www.pavuk.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="nls ssl"

DEPEND=">=sys-apps/sed-4
	sys-devel/gettext
	ssl? ( dev-libs/openssl )"

RDEPEND="virtual/libintl
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-0.9.34-nls.patch
}

src_compile() {
	econf \
		--enable-threads \
		--with-regex=auto \
		--disable-socks \
		--disable-gtk \
		$(use_enable ssl) \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README CREDITS NEWS AUTHORS BUGS \
		TODO MAILINGLIST ChangeLog wget-pavuk.HOWTO jsbind.txt \
		pavuk_authinfo.sample  pavukrc.sample
}
