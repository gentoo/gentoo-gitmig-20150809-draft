# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_xslt/mod_xslt-1.0.5a-r1.ebuild,v 1.1 2005/01/10 23:08:18 trapni Exp $

inherit eutils apache-module

DESCRIPTION="An xslt filtering DSO module for Apache2"
HOMEPAGE="http://www.mod-xslt.com/"
SRC_URI="http://www.dunkel.org/mod-xslt/downloads/mod-xslt-${PV}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"

DEPEND="dev-lang/perl
		dev-libs/libxslt
		dev-libs/libxml2
		dev-util/pkgconfig"

S=${WORKDIR}/mod-xslt-${PV}

APXS2_ARGS="-c ${PN}.c iotools.c logging.c urltools.c xsltools.c"
APACHE2_MOD_CONF="${PVR}/25_mod_xslt"
#APACHE2_MOD_FILE='.libs/mod_xslt.so'

DOCFILES="AUTHORS ChangeLog LICENSE NEWS README*"

need_apache2

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	epatch ${FILESDIR}/mod_xslt-1.0.5a-register.patch
	epatch ${FILESDIR}/mod-xslt-1.0.5a-debug.patch
	epatch ${FILESDIR}/mod-xslt-1.0.5a-content.patch
	epatch ${FILESDIR}/mod_xslt-1.05a.patch

	sed -i -e 's,libxml/,libxml2/libxml/,' configure.ac

	find src -type f | xargs perl -pi -e "s,libxml/,libxml2/libxml/,g;"

	autoconf || die
	touch config.h && cd src
	mv mod-xslt.c mod_xslt.c
}

src_compile() {
	APXS2_ARGS="$(pkg-config --cflags --libs libxslt) ${APXS2_ARGS}"
	apache2_src_compile
}

# vim:ts=4
