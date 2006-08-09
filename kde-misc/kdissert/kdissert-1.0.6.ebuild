# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-1.0.6.ebuild,v 1.1 2006/08/09 13:16:56 carlo Exp $

inherit kde

MY_P="${P}-waf"
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND=""
need-kde 3.5

#LANGS="bg br cs da de el es fr ga gl it ka nl pl pt_BR pt ru sv tr"

src_unpack() {
	unpack ${A}
	cd ${S}
	tar xjvf miniwaf.tar.bz2 1> /dev/null
}
src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="--kdeincludes=$(kde-config --prefix)/include --prefix=/usr "
	use amd64 && myconf="${myconf} --libsuffix=64"

	./waf.py configure ${myconf} || die "configure failed"
	./waf.py ${MAKEOPTS} || die "waf failed"
}

src_install() {
	./waf.py --destdir="${D}" install
	dodoc AUTHORS COPYING INSTALL README ROADMAP
}
