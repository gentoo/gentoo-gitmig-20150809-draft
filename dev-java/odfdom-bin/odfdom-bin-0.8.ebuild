# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/odfdom-bin/odfdom-bin-0.8.ebuild,v 1.5 2010/05/25 10:00:23 ali_bush Exp $

EAPI=3

JAVA_PKG_IUSE="doc"

inherit java-pkg-2

MY_PN=${PN/-bin}
MY_P=${P/-bin}
DESCRIPTION="The ODFDOM reference implementation, written in Java."
HOMEPAGE="http://odftoolkit.org/projects/odfdom"
SRC_URI="http://odftoolkit.org/projects/odfdom/downloads/download/current-version%252F${MY_P}-binary.zip  -> ${MY_P}-binary.zip
	doc? ( http://odftoolkit.org/projects/odfdom/downloads/download/current-version%252F${MY_P}-javadoc.zip -> ${MY_P}-javadoc.zip )
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc-aix ~hppa-hpux ~ia64-hpux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/jre-1.5
	dev-java/xerces:2
"
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	default
	if use doc; then
		# java-pkg_dojavadoc() likes dirname "api"
		mv ${MY_P}-javadoc/${MY_P}-javadoc api || die
	fi
}

src_install() {
	java-pkg_register-dependency xerces-2
	java-pkg_dojar odfdom.jar

	dodoc README.txt LICENSE.txt || die
	use doc && java-pkg_dojavadoc api
}
