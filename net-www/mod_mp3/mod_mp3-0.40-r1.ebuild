# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_mp3/mod_mp3-0.40-r1.ebuild,v 1.1 2005/01/07 19:26:00 vericgar Exp $

inherit apache-module

# test target in Makefile isn't sane
RESTRICT="maketest"

IUSE="mysql postgres"

DESCRIPTION="Module for turning Apache into an MP3 or Ogg streaming server"
HOMEPAGE="http://software.tangent.org/"
KEYWORDS="~x86 ~sparc ~ppc"

SRC_URI="http://download.tangent.org/${P}.tar.gz"

DEPEND="dev-lang/perl
	mysql? ( >=dev-db/mysql-3.23.26 )
	postgres? ( dev-db/postgresql )"

LICENSE="as-is"
SLOT="0"

APXS1_S="${S}"

APACHE1_MOD_FILE="src/${PN}.so"
APACHE1_MOD_CONF="50_mod_mp3"
APACHE1_MOD_DEFINE="MP3"

DOCFILES="CONTRIBUTORS ChangeLog LICENSE README TODO faq.html support/*"

need_apache1

src_compile() {
	local myconf

	myconf="$(use_with mysql)"
	myconf="${myconf} $(use_with postgres)"
	./configure ${myconf} --with-playlist || die "configure failed"
	make || die "make failed"
}
