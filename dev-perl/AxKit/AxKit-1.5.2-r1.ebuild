# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AxKit/AxKit-1.5.2-r1.ebuild,v 1.13 2002/12/15 10:44:12 bjb Exp $

inherit perl-module

S=${WORKDIR}/${PN}-1.52
DESCRIPTION="The Apache AxKit Perl Module"
SRC_URI="http://axkit.org/download/${P}.tar.gz"
HOMEPAGE="http://axkit.org/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

newdepend ">=dev-perl/libapreq-0.31 \
	>=dev-perl/Compress-Zlib-1.10 \
	>=dev-perl/Error-0.13 \
	>=dev-perl/HTTP-GHTTP-1.06 \
	>=dev-perl/Storable-1.0.7 \
	>=dev-perl/XML-XPath-1.04 \
	>=dev-perl/XML-XPath-1.04 \
	>=dev-perl/XML-LibXML-1.31 \
	>=dev-perl/XML-LibXSLT-1.31 \
	>=dev-perl/libapreq-1.0 \
	>=dev-perl/XML-Sablot-0.50"

APACHE_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
[ -z "${APACHE_ROOT}" ] && APACHE_ROOT="/home/httpd/htdocs"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.PL Makefile.PL.orig
	sed -e "s:0\.31_03:0.31:" Makefile.PL.orig > Makefile.PL
}

src_install() {
	perl-module_src_install

	diropts -o nobody -g nogroup
	dodir /var/cache/axkit
	dodir ${APACHE_ROOT}/xslt
	insinto /etc/apache
	doins ${FILESDIR}/httpd.axkit
}
