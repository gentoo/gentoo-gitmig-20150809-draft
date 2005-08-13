# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-1.2.11.ebuild,v 1.8 2005/08/13 23:27:16 hansmi Exp $

inherit distutils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/"
#SRC_URI="mirror://gentoo/java-config-${PV}.tar.bz2"
SRC_URI="http://www.gentoo.org/~karltk/projects/java/distfiles/java-config-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/python"

src_install() {
	distutils_src_install
	dobin ${S}/java-config
	doman ${S}/java-config.1

	insinto /etc/env.d
	doins ${S}/30java-finalclasspath
}
