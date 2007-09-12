# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrrd/jrrd-1.0.1.ebuild,v 1.1 2007/09/12 04:58:46 wltjr Exp $

inherit eutils java-pkg-2

DESCRIPTION="Java Interface to Tobias Oetiker's RRDtool"

SLOT="0"
SRC_URI="mirror://sourceforge/opennms/${P}.tar.gz"
HOMEPAGE="http://www.opennms.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"

COMMON_DEP="net-analyzer/rrdtool"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${P}"

src_compile(){
	cd "${S}"
	econf || die "Could not configure ${P}"
	emake || die "Could not build ${P}"
}

src_install() {
	cd "${S}"
	java-pkg_newjar "${S}/${PN}.jar"
	make DESTDIR="${D}" install || die "Could not install lib${PN}.so"
# ugly but effective
	rm -fR "${D}/usr/share/java" || die "Could not remove extra jar"
}

