# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pino/pino-0.2.6.ebuild,v 1.1 2010/04/16 08:53:15 nirbheek Exp $

EAPI="2"

DESCRIPTION="Twitter and Identi.ca desktop client written in Vala"
HOMEPAGE="http://code.google.com/p/pino-twitter/"
SRC_URI="http://pino-twitter.googlecode.com/files/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.14
	>=x11-libs/gtk+-2.10
	>=dev-libs/libgee-0.5.0
	>=net-libs/libsoup-2.4

	app-text/gtkspell
	x11-libs/libnotify
	dev-libs/libxml2:2
	dev-libs/libunique
	net-libs/webkit-gtk"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.7
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS INSTALL README"

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" \
	./waf --prefix=/usr \
		configure || die "./waf configure failed"
}

src_compile() {
	local myjobs=$(echo "$MAKEOPTS" | sed -n -e 's,.*\(-j[[:digit:]]\+\).*,\1,p')
	./waf ${myjobs} build || die "./waf configure failed"
}

src_install() {
	./waf \
		--destdir="${D}" \
		install || die "./waf install failed"
	dodoc ${DOCS}
}
