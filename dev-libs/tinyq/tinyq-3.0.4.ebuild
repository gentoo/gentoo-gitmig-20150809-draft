# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tinyq/tinyq-3.0.4.ebuild,v 1.10 2004/03/14 12:24:39 mr_bones_ Exp $

DESCRIPTION="Stripped down version of qt ${PV} for console development"
SRC_URI="mirror://sourceforge/tinyqt/tinyq-${PV}.tar.bz2"
HOMEPAGE="http://www.uwyn.com/projects/tinyq"

SLOT="3"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=dev-util/yacc-1.9.1-r1
	>=sys-devel/flex-2.5.4a-r4"

QTBASE=/usr/qt/tinyq
export QTDIR=${S}

src_compile() {

	./configure -release -no-g++-exceptions -prefix /usr/qt/tinyq || die
	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
	insinto /etc/env.d
	doins ${FILESDIR}/47tinyq
}
