# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.1.12.ebuild,v 1.3 2003/05/13 20:55:21 taviso Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libgcrypt is a general purpose crypto library based on the code used in GnuPG."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="doc? ( app-text/jadetex
	app-text/docbook-sgml-utils
	>=app-text/docbook-dsssl-stylesheets-1.77-r2 )"

RDEPEND="nls? ( sys-devel/gettext )"
IUSE="doc nls"

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
	emake  || die
}

src_install () {	
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING* NEWS README* THANKS TODO VERSION 
}
