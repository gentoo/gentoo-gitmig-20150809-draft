# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-2.1.10.ebuild,v 1.1 2007/04/01 20:09:14 anant Exp $

inherit eutils

DESCRIPTION="Firewall Builder 2.0 API library and compiler framework"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="snmp ssl"

DEPEND=">=dev-libs/libxml2-2.4.10
	>=dev-libs/libxslt-1.0.7
	snmp? ( net-analyzer/net-snmp )
	ssl? ( dev-libs/openssl )
	=x11-libs/qt-3*"

src_compile() {
	export QMAKE="${QTDIR}/bin/qmake"
	econf `use_with ssl openssl` `use_with snmp ucdsnmp` --without-stlport --without-lwres || die
	emake || die
}

src_install() {
	make DDIR="${D}" install || die
	prepalldocs
}
