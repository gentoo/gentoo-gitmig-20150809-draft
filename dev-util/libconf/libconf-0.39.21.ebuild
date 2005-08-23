# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/libconf/libconf-0.39.21.ebuild,v 1.3 2005/08/23 16:52:06 agriffis Exp $

IUSE=""

MY_P=perl-${PN/l/L}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Centralized abstraction layer for system configuration files"
HOMEPAGE="http://libconf.net/"
SRC_URI="http://libconf.net/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ia64 ~mips ppc ppc64 ~sparc x86"

DEPEND="dev-lang/perl"

src_compile() {
	emake || die "make failed"
	make test || die "make test failed"
}

src_install() {
	einstall PREFIX=${D}/usr
	dodoc AUTHORS COPYING ChangeLog
}
