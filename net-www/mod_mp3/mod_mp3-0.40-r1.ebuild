# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_mp3/mod_mp3-0.40-r1.ebuild,v 1.9 2007/01/14 18:15:40 chtekk Exp $

inherit apache-module

KEYWORDS="ppc x86"

DESCRIPTION="Module for turning Apache1 into an MP3 or Ogg streaming server."
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
IUSE="mysql postgres"

DEPEND="dev-lang/perl
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}"

# Test target in Makefile isn't sane
RESTRICT="test"

APACHE1_MOD_CONF="50_mod_mp3"
APACHE1_MOD_DEFINE="MP3"

DOCFILES="CONTRIBUTORS ChangeLog LICENSE README faq.html support/*"

need_apache1

src_compile() {
	local myconf="--with-playlist"
	myconf="${myconf} $(use_with mysql)"
	myconf="${myconf} $(use_with postgres)"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}
