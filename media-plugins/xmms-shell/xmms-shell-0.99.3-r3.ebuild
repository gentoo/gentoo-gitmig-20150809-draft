# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shell/xmms-shell-0.99.3-r3.ebuild,v 1.10 2006/05/19 17:58:18 corsair Exp $

inherit eutils

DESCRIPTION="simple utility to control XMMS externally"
SRC_URI="mirror://sourceforge/xmms-shell/${P}.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE="readline"

RESTRICT="primaryuri"

RDEPEND=">=media-sound/xmms-1.2.7
	readline? ( >=sys-libs/readline-4.1 )"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix configure.in to detect readline
	epatch ${FILESDIR}/${PN}-readline.patch

	# Fix null pointer when default skin
	epatch ${FILESDIR}/${PN}-null-skin.patch

	# Remove unnecessary playlist exception
	epatch ${FILESDIR}/${PN}-playlist.patch

	WANT_AUTOCONF=2.5
	WANT_AUTOMAKE=1.4
	aclocal
	automake --gnu --include-deps Makefile
	autoconf

	# Fix compilation in gcc3.3
	sed -i -e 's/<string>/<string.h>/' ${S}/src/getline.cc
}

src_compile() {
	econf \
		$(use_with readline) \
		|| die "Configuration failed."

	emake || die "Make failed."
}

src_install() {
	make DESTDIR=${D} install || die "Install failed."
	dodoc AUTHORS ChangeLog README
}

