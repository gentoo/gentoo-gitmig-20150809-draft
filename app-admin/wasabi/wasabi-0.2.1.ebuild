# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

inherit eutils

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://www.gentoo.org/~lcars/wasabi"
SRC_URI="http://www.gentoo.org/~lcars/wasabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="sys-apps/coreutils"

pkg_preinst() {
	enewgroup wasabi
	enewuser  wasabi -1 /bin/false /var/lib/wasabi wasabi
}

src_install() {
	emake DESTDIR=${D} install
	doman wasabi.8
	exeinto /etc/init.d
	newexe wasabi.gentoo-init wasabi
	fowners wasabi:root /etc/wasabi/wasabi.conf
	keepdir /var/lib/wasabi
}
