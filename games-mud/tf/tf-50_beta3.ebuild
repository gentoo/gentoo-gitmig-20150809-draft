# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-50_beta3.ebuild,v 1.1 2004/02/12 06:52:12 mr_bones_ Exp $

inherit games

MY_P="${P/_beta/b}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION='A small, flexible, screen-oriented MUD client'
HOMEPAGE='http://tf.tcp.com/~hawkeye/tf/'
SRC_URI="http://ftp.tcp.com/pub/mud/Clients/tinyfugue/${MY_P}.tar.gz
	doc? ( http://ftp.tcp.com/pub/mud/Clients/tinyfugue/${MY_P}-help.tar.gz )"

KEYWORDS='~x86'
LICENSE='GPL-2'
SLOT='0'

IUSE='ipv6 doc debug ssl'

DEPEND='virtual/glibc
	sys-libs/zlib
	ssl? ( dev-libs/openssl )
	>=sys-libs/ncurses-5.2'

src_compile() {
	egamesconf \
		`use_enable ssl` \
		`use_enable debug core` \
		`use_enable ipv6 inet6` \
		--enable-manpage || die
	emake || die 'emake failed'
}

src_install() {
	dogamesbin src/tf
	newman src/tf.1.catman tf.1
	dodoc CHANGES CREDITS README

	insinto ${GAMES_LIBDIR}/${PN}-lib
	# the application looks for this file here if /changes is called.
	# see comments on bug #23274
	doins CHANGES
	insopts -m0755
	doins tf-lib/*
	if use doc ; then
		cd ${WORKDIR}/${MY_P}-help
		doins tf-help
		# the html expects to find the CHANGES file uncompressed so...
		gzip -d ${D}/usr/share/doc/${P}/CHANGES.gz
		dohtml -r *.html commands topics
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	use ipv6 && {
		echo
		ewarn 'You have merged TinyFugue with IPv6-support.'
		ewarn 'Support for IPv6 is still being experimental.'
		ewarn 'If you experience problems with connecting to hosts,'
		ewarn 'try re-merging this package with USE="-ipv6"'
		echo
	}
}
