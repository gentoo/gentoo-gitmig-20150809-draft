# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_xslt/mod_xslt-1.0.5a.ebuild,v 1.9 2004/09/03 23:24:08 pvdabeel Exp $

inherit eutils

DESCRIPTION="An xslt filtering DSO module for Apache2"
HOMEPAGE="http://www.mod-xslt.com/"

S=${WORKDIR}/mod-xslt-${PV}
SRC_URI="http://www.dunkel.org/mod-xslt/downloads/mod-xslt-${PV}.tar.gz"
DEPEND="dev-lang/perl dev-libs/libxslt dev-libs/libxml2
	=net-www/apache-2* dev-util/pkgconfig"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_xslt-1.0.5a-register.patch
	epatch ${FILESDIR}/mod-xslt-1.0.5a-debug.patch
	epatch ${FILESDIR}/mod-xslt-1.0.5a-content.patch
	epatch ${FILESDIR}/mod_xslt-1.05a.patch
	#oh brother
	cp configure.ac configure.ac.orig
	sed -e 's|libxml/|libxml2/libxml/|' configure.ac.orig > configure.ac
	rm -f configure configure.ac.orig
	find src -type f | xargs perl -pi -e "s|libxml/|libxml2/libxml/|g;"
	autoconf || die
}

src_compile() {
	touch config.h && cd src
	mv mod-xslt.c mod_xslt.c
	/usr/sbin/apxs2 `pkg-config --cflags --libs libxslt` \
		-c ${PN}.c iotools.c logging.c urltools.c xsltools.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe src/.libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/25_mod_xslt.conf
	dodoc ${FILESDIR}/25_mod_xslt.conf
	dodoc AUTHORS ChangeLog LICENSE NEWS README*
}
