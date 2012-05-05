# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gxmessage/gxmessage-2.12.4.ebuild,v 1.2 2012/05/05 04:53:42 jdhore Exp $

EAPI=2

DESCRIPTION="A GTK+ based xmessage clone"
HOMEPAGE="http://homepages.ihug.co.nz/~trmusson/programs.html#gxmessage"
SRC_URI="http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-3 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( >=dev-util/intltool-0.40
		sys-devel/gettext )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO

	docinto examples
	dodoc examples/*
}
