# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-50_alpha11.ebuild,v 1.2 2004/02/03 01:07:09 mr_bones_ Exp $

inherit games

MY_P="${P/_alpha/a}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION='A small, flexible, screen-oriented MUD client'
HOMEPAGE='http://tf.tcp.com/~hawkeye/tf/'
SRC_URI="http://ftp.tcp.com/pub/mud/Clients/tinyfugue/${MY_P}.tar.gz"

KEYWORDS='~x86'
LICENSE='GPL-2'
SLOT='0'

IUSE='ipv6 doc debug'

DEPEND='sys-libs/zlib
	>=sys-libs/ncurses-5.2'

src_compile() {
	local myconf
	use debug || myconf="--enable-strip"
	use ipv6 && myconf="${myconf} --enable-inet6"

	egamesconf ${myconf} --enable-manpage || die
	emake || die 'emake failed'
}

src_install() {
	dogamesbin src/tf
	newman src/tf.1.catman tf.1

	insinto ${GAMES_LIBDIR}/${PN}-lib
	insopts -m0755
	doins tf-lib/*
	# the application looks for this file here # if /changes is called.
	# see comments on bug 23274
	doins CHANGES

	dodoc CHANGES CREDITS README

	use doc && dohtml -r help/*
	# the html expects to find the CHANGES file uncompressed so...
	use doc && gzip -d ${D}/usr/share/doc/${P}/CHANGES.gz
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
