# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-1.3.6-r1.ebuild,v 1.1 2006/09/11 18:04:47 nichoj Exp $

inherit base distutils eutils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/python
	dev-java/java-config-wrapper"

PATCHES="${FILESDIR}/${P}-jh.patch"

src_install() {
	distutils_src_install
	newbin java-config java-config-1
	doman java-config.1

	doenvd 30java-finalclasspath
}

pkg_postinst() {
	einfo "The way Java is handled on Gentoo has been recently updated."
	einfo "If you have not done so already, you should follow the"
	einfo "instructions available at:"
	einfo "\thttp://www.gentoo.org/proj/en/java/java-upgrade.xml"
	echo
	einfo "While we moving towards the new Java system, we only allow"
	einfo "1.3 or 1.4 JDKs to be used with java-config-1 to ensure"
	einfo "backwards compatibility with the old system."
	einfo "For more details about this, please see:"
	einfo "\thttps://overlays.gentoo.org/proj/java/wiki/Why_We_Need_Java14"
}
