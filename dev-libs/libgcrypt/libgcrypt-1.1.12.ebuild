# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.1.12.ebuild,v 1.15 2005/01/12 14:46:12 dragonheart Exp $

DESCRIPTION="general purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 amd64 hppa"
IUSE="doc nls"

DEPEND="doc? ( app-text/jadetex
	app-text/docbook-sgml-utils
	>=app-text/docbook-dsssl-stylesheets-1.77-r2 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}/scripts

	mv db2any db2any.orig
	sed -e 's:docbook-to-man:docbook2man:g' \
		-e 's:\^usage:^Usage:' \
		-e 's:^/usr/share/dsssl/stylesheets/docbook:/usr/share/sgml/stylesheets/dsssl/docbook:' \
		db2any.orig > db2any
	chmod +x db2any
}

src_compile() {
	econf $(use_enable nls) --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING* NEWS README* THANKS TODO VERSION
}
