# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shell/xmms-shell-0.99.3-r1.ebuild,v 1.1 2004/02/04 08:42:37 eradicator Exp $

S=${WORKDIR}/${P}

DESCRIPTION="simple utility to control XMMS externally"
SRC_URI="mirror://sourceforge/xmms-shell/${P}.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="readline"

RDEPEND=">=media-sound/xmms-1.2.7
	readline? ( >=sys-libs/readline-4.1 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix configure.in to detect readline
	epatch ${FILESDIR}/${PN}-readline.patch

	WANT_AUTOCONF=2.1
	WANT_AUTOMAKE=1.4
	aclocal
	automake --gnu --include-deps Makefile
	autoconf
}

src_compile() {
	econf `use_with readline` || die "Configuration failed."
	emake || die "Make failed."
}

src_install() {
	make DESTDIR=${D} install || die "Install failed."
	dodoc AUTHORS ChangeLog INSTALL README
}

