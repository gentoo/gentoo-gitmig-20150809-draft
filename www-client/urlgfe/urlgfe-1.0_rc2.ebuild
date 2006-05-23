# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/urlgfe/urlgfe-1.0_rc2.ebuild,v 1.1 2006/05/23 19:10:15 swegener Exp $

MY_P="${P/_/}"

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://urlget.sourceforge.net/"
SRC_URI="mirror://sourceforge/urlget/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=net-misc/curl-7.10
	>=x11-libs/gtk+-2.4
	>=dev-libs/glib-2
	dev-libs/libpcre"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
