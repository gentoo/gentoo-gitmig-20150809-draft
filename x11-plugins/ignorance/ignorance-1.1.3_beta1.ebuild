# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ignorance/ignorance-1.1.3_beta1.ebuild,v 1.1 2005/04/03 21:14:07 anarchy Exp $

inherit eutils

MY_PV=${P/_beta/beta}

DESCRIPTION="GAIM Advanced Ignore filter"
HOMEPAGE="http://bard.sytes.net/ignorance/"
SRC_URI="http://bard.sytes.net/ignorance/${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1"

S=${WORKDIR}/${MY_PV}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc ChangeLog INSTALL README AUTHORS
}
