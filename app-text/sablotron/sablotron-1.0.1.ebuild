# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-1.0.1.ebuild,v 1.7 2004/08/02 02:50:04 tgall Exp $

inherit libtool gnuconfig

MY_PN="Sablot"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="An XSLT Parser in C++"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"
SRC_URI="http://download-1.gingerall.cz/download/sablot/${MY_P}.tar.gz"

# Sablotron can optionally be built under GPL, using MPL for now
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~alpha arm ~hppa ~amd64 ~ia64 s390 ppc64"
IUSE="doc perl"

DEPEND=">=dev-libs/expat-1.95.6-r1
	>=dev-perl/XML-Parser-2.3"

DOCS="INSTALL README README_JS RELEASE src/TODO"

src_compile() {
	local myconf=

	# Detect mips systems properly
	gnuconfig_update

	# Please do not remove, else we get references to PORTAGE_TMPDIR
	# in /usr/lib/libsablot.la ...
	elibtoolize

	use perl \
		&& myconf="${myconf} --enable-perlconnect"

	use doc \
		&& myconf="${myconf} --with-html-dir=${D}/usr/share/doc/${P}/html" \
		|| myconf="${myconf} --without-html-dir"

	# rphillips, fixes bug #3876
	# this is fixed for me with apache2, but keeping it in here
	# for apache1 users and/or until some clever detection
	# is added <obz@gentoo.org>
	export LDFLAGS="-lstdc++"

	econf ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ${DOCS}
}
