# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-50_beta8.ebuild,v 1.5 2011/03/28 13:22:09 phajdan.jr Exp $

inherit games

MY_P="${P/_beta/b}"
DESCRIPTION="A small, flexible, screen-oriented MUD client (aka TinyFugue)"
HOMEPAGE="http://tinyfugue.sourceforge.net/"
SRC_URI="mirror://sourceforge/tinyfugue/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/tinyfugue/${MY_P}-help.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="debug doc ipv6 ssl"

DEPEND="ssl? ( dev-libs/openssl )
	dev-libs/libpcre"

S=${WORKDIR}/${MY_P}

src_compile() {
	STRIP=: egamesconf \
		$(use_enable ssl) \
		$(use_enable debug core) \
		$(use_enable ipv6 inet6) \
		--enable-manpage || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/tf || die "dogamesbin failed"
	newman src/tf.1.nroffman tf.1
	dodoc CHANGES CREDITS README

	insinto "${GAMES_DATADIR}"/${PN}-lib
	# the application looks for this file here if /changes is called.
	# see comments on bug #23274
	doins CHANGES || die "doins failed"
	insopts -m0755
	doins tf-lib/* || die "doins failed"
	if use doc ; then
		dohtml -r *.html commands topics
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	use ipv6 && {
		echo
		ewarn "You have merged TinyFugue with IPv6-support."
		ewarn "Support for IPv6 is still being experimental."
		ewarn "If you experience problems with connecting to hosts,"
		ewarn "try re-merging this package with USE="-ipv6""
		echo
	}
}
