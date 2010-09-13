# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-4.1.1.ebuild,v 1.1 2010/09/13 01:02:23 kumba Exp $

EAPI="2"

inherit eutils qt4-r2 multilib autotools

DESCRIPTION="Firewall Builder 4.0 API library and compiler framework"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE="snmp"

DEPEND=">=dev-libs/libxml2-2.4.10
	>=dev-libs/libxslt-1.0.7
	snmp? ( net-analyzer/net-snmp )
	>=x11-libs/qt-core-4.3"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4-r2_src_prepare
	epatch "${FILESDIR}/4.x-qmake-use-LDFLAGS.patch"
	eautoreconf || die "eautoreconf failed"

	# This package fundamentally changed its build system.  We have to
	# manually copy config.{sub,guess} from /usr/share/gnuconfig/.
	cp /usr/share/gnuconfig/config.{sub,guess} "${WORKDIR}/${P}/"	\
		|| die "failed to copy config.{sub,guess}"
}

src_configure() {
	use snmp || export with_ucdsnmp="no"
	econf || die "econf failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
