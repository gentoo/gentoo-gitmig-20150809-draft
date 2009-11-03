# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-xmpp/irssi-xmpp-0.50.ebuild,v 1.2 2009/11/03 17:50:43 dertobi123 Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="An irssi plugin providing Jabber/XMPP support"
HOMEPAGE="http://cybione.org/~irssi-xmpp/"
SRC_URI="http://cybione.org/~${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-irc/irssi-0.8.13
	>=net-libs/loudmouth-1.2.0[debug]"
RDEPEND="${DEPEND}"

src_prepare() {
	# Patch config.mk to include local CFLAGS and LDFLAGS.
	# Those can probably be removed after 0.50 since upstream fixed it.
	# Also set PREFIX and CC to the values we prefer.
	sed -i \
		-e "s#^CFLAGS = #CFLAGS = ${CFLAGS} #" \
		-e "s#^LDFLAGS = #LDFLAGS = ${LDFLAGS} #" \
		-e "/^PREFIX ?\\?= /cPREFIX = /usr" \
		-e "/^CC = /cCC = $(tc-getCC)" \
		config.mk || die "patching config.mk failed"
	# Patch Makefile to remove /irssi-xmpp suffix for docs.
	sed -i -e 's#\${IRSSI_DOC}/irssi-xmpp$#${IRSSI_DOC}#' \
		Makefile || die "patching Makefile failed"
}

src_install() {
	emake DESTDIR="${D}" IRSSI_DOC="/usr/share/doc/${PF}" \
		install || die "install failed"
}
