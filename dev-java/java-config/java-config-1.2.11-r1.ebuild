# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-1.2.11-r1.ebuild,v 1.11 2006/04/16 06:52:08 vapier Exp $

inherit distutils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/"
#SRC_URI="mirror://gentoo/java-config-${PV}.tar.bz2"
SRC_URI="http://www.gentoo.org/~karltk/projects/java/distfiles/java-config-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-shebang.patch
}

src_install() {
	distutils_src_install
	dobin ${S}/java-config
	doman ${S}/java-config.1

	insinto /etc/env.d
	doins ${S}/30java-finalclasspath
}
