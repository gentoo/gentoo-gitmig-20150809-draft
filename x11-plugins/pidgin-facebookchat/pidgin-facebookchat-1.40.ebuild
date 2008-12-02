# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-facebookchat/pidgin-facebookchat-1.40.ebuild,v 1.1 2008/12/02 22:16:46 voyageur Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Facebook chat plugin for libpurple"
HOMEPAGE="http://code.google.com/p/pidgin-facebookchat/"

SRC_URI="http://pidgin-facebookchat.googlecode.com/files/${PN}-source-${PV}.tar.bz2"
LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

S=${WORKDIR}

src_compile() {
	# Grabbed from makefile
	FACEBOOK_SOURCES="libfacebook.c fb_blist.c fb_connection.c fb_info.c fb_managefriends.c fb_messages.c fb_notifications.c fb_search.c"
	# Remove NO_ZLIB when it's working
	$(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} `pkg-config --cflags purple` \
		-DPURPLE_PLUGINS -DENABLE_NLS -DNO_ZLIB -shared -fPIC -DPIC \
		${FACEBOOK_SOURCES} -o libfacebook.so || die "compilation failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/purple-2
	doexe libfacebook.so
	for size in 16 22 48; do
		insinto /usr/share/pixmaps/pidgin/protocols/${size}
		newins facebook${size}.png facebook.png
	done
}
