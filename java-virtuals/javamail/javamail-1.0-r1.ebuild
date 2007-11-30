# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/javamail/javamail-1.0-r1.ebuild,v 1.2 2007/11/30 13:35:41 corsair Exp $

inherit java-virtuals-2

DESCRIPTION="Virtual for javamail implementations"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( dev-java/sun-javamail >=dev-java/gnu-javamail-1.0-r2 )
		!<dev-java/gnu-javamail-1.0-r2"

JAVA_VIRTUAL_PROVIDES="sun-javamail gnu-javamail-1"
