# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qmtest/qmtest-2.3.ebuild,v 1.4 2008/05/02 17:16:20 kanaka Exp $

inherit eutils distutils
DESCRIPTION="CodeSourcery's test harness system"
HOMEPAGE="http://www.codesourcery.com/qmtest/"
MY_P=qm-${PV}
SRC_URI="http://www.codesourcery.com/public/${PN}/${MY_P}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~x86 ~mips"
IUSE=""

DEPEND="dev-lang/python"

S=${WORKDIR}/${MY_P}
