# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-2.1.13-r1.ebuild,v 1.2 2007/09/06 00:29:38 r3pek Exp $

inherit eutils qt3

DESCRIPTION="Firewall Builder 2.1 API library and compiler framework"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="snmp ssl stlport"

DEPEND=">=dev-libs/libxml2-2.4.10
	>=dev-libs/libxslt-1.0.7
	snmp? ( net-analyzer/net-snmp )
	ssl? ( dev-libs/openssl )
	stlport? ( dev-libs/STLport )
	$(qt_min_version 3)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc42.patch
}

src_compile() {
	# we'll use our eqmake instead of bundled script to process qmake files
	sed -i -e 's:^. ./runqmake.sh$:echo:' configure \
		|| die "sed configure failed"

	econf   $(use_with ssl openssl) \
		$(use_with snmp ucdsnmp) \
		$(use_with stlport stlport) \
		|| die "configure failed"

	# use eqmake to generate Makefiles
	eqmake3 ${PN}.pro
	for subdir in src src/fwbuilder src/fwcompiler src/test src/confscript \
			etc doc migration; do
		eqmake3 "${subdir}/${subdir##*/}.pro" -o ${subdir}/Makefile
	done

	emake || die "Compilation failed"
}

src_install() {
	emake install DDIR="${D}" || die "Install failed"

	cd "${D}"/usr/share/doc/${PF}
	rm COPYING INSTALL
	prepalldocs
}
