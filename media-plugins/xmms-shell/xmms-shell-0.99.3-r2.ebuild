# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shell/xmms-shell-0.99.3-r2.ebuild,v 1.2 2004/03/26 22:23:30 eradicator Exp $

inherit eutils

DESCRIPTION="simple utility to control XMMS externally"
SRC_URI="mirror://sourceforge/xmms-shell/${P}.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="readline"

RDEPEND=">=media-sound/xmms-1.2.7
	readline? ( >=sys-libs/readline-4.1 )"

DEPEND="${RDEPEND}
	sys-apps/sed
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix configure.in to detect readline
	epatch ${FILESDIR}/${PN}-readline.patch

	# Fix null pointer when default skin
	epatch ${FILESDIR}/${PN}-null-skin.patch

	WANT_AUTOCONF=2.1
	WANT_AUTOMAKE=1.4
	aclocal
	automake --gnu --include-deps Makefile
	autoconf

	# Fix compilation in gcc3.3
	mv ${S}/src/getline.cc ${S}/src/getline.cc.orig
	sed 's/<string>/<string.h>/' < ${S}/src/getline.cc.orig > ${S}/src/getline.cc
}

src_compile() {
	econf `use_with readline` || die "Configuration failed."
	emake || die "Make failed."
}

src_install() {
	make DESTDIR=${D} install || die "Install failed."
	dodoc AUTHORS ChangeLog INSTALL README
}

