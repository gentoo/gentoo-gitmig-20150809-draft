# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mserv/mserv-0.35-r1.ebuild,v 1.7 2007/01/05 17:39:09 flameeyes Exp $

inherit webapp eutils toolchain-funcs

DESCRIPTION="Jukebox-style music server"
HOMEPAGE="http://www.mserv.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="mserv"

KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE="vorbis"

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

RDEPEND=">=dev-lang/perl-5.6.1
	virtual/mpg123
	media-sound/sox
	net-www/apache
	vorbis? ( media-sound/vorbis-tools )"

pkg_setup() {
	webapp_pkg_setup
	enewgroup mserv
	enewuser mserv -1 -1 /dev/null mserv -G audio
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Adjust paths to match Gentoo
	epatch ${FILESDIR}/${P}-paths.patch || die
	# Mservplay uses stricmp - should be strcasecmp
	epatch ${FILESDIR}/${P}-mservplay.patch || die
}

src_compile() {
	econf || die
	emake || die

	# Optional suid wrapper
	cd ${S}/support
	$(tc-getCC) -I.. -I../mserv ${CFLAGS} ${LDFLAGS} mservplay.c -o mservplay || die
}

src_install() {
	webapp_src_preinst

	make DESTDIR=${D} install || die

	dobin support/mservedit support/mservripcd support/mservplay
	dodoc AUTHORS ChangeLog docs/quick-start.txt

	# Web client
	dodir ${MY_CGIBINDIR}/${PN}
	cp webclient/*.cgi ${D}/${MY_CGIBINDIR}/${PN}
	cp webclient/*.gif webclient/index.html ${D}/${MY_HTDOCSDIR}

	webapp_src_install

	# Configuration files
	insopts -o mserv -g mserv -m0644
	insinto /etc/mserv
	fowners mserv:mserv /etc/mserv
	newins ${FILESDIR}/${P}-config config
	newins ${FILESDIR}/${P}-webacl webacl
	newins ${FILESDIR}/${P}-acl acl
	insinto ${MY_HOSTROOTDIR}/${PN}
	fowners mserv:mserv ${MY_HOSTROOTDIR}/${PN}
	newins ${FILESDIR}/${P}-config config
	newins ${FILESDIR}/${P}-webacl webacl
	newins ${FILESDIR}/${P}-acl acl
	fperms 0600 ${MY_HOSTROOTDIR}/${PN}/acl

	newinitd ${FILESDIR}/${P}-initd ${PN}
	newconfd ${FILESDIR}/${P}-confd ${PN}

	# Log file
	dodir /var/log
	touch ${D}var/log/mserv.log
	fowners mserv:mserv /var/log/mserv.log

	# Track and album info
	keepdir /var/lib/mserv/trackinfo
	fowners mserv:mserv /var/lib/mserv/trackinfo

	# Current track output
	dodir /var/spool/mserv
	touch ${D}var/spool/mserv/player.out
	fowners mserv:mserv /var/spool/mserv /var/spool/mserv/player.out
}

pkg_postinst() {
	elog
	elog "The wrapper program 'mservplay' is disabled for"
	elog "security reasons.  If you wish to use mservplay"
	elog "to pass a 'nice' value to mpg123, you must make"
	elog "/usr/bin/mservplay suid root."
	ewarn
	ewarn "Please edit /etc/mserv/config and set path_tracks"
	ewarn "to the location of your music files."
	webapp_pkg_postinst
}
