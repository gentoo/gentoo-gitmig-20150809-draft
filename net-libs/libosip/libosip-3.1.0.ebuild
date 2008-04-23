# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-3.1.0.ebuild,v 1.2 2008/04/23 21:21:06 maekke Exp $

MY_PV=${PV%.?}-${PV##*.}
MY_PV=${PV}
MY_P=${PN}2-${MY_PV}
DESCRIPTION="a simple way to support the Session Initiation Protocol"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_compile() {
	# for later - --enable-hashtable - requires libdict (whatever that is)
	econf --enable-mt || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
	dodoc AUTHORS BUGS ChangeLog FEATURES HISTORY README NEWS TODO
}
