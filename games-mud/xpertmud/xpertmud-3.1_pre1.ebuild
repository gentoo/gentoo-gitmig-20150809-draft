# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/xpertmud/xpertmud-3.1_pre1.ebuild,v 1.1 2004/02/23 00:19:15 vapier Exp $

inherit kde
need-kde 3

MY_PV="${PV/_pre/preview}"
DESCRIPTION="the eXtensible Python pErl Ruby scripTable MUD client"
HOMEPAGE="http://xpertmud.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpertmud/xpertmud-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="python ruby"

DEPEND=">=sys-devel/libperl-5.6.1
	python? ( >=dev-lang/python-2.2 )
	ruby? ( >=dev-lang/ruby-1.8.0 )"

S=${WORKDIR}/xpertmud-${MY_PV}

src_compile() {
	econf \
		`use_with python python` \
		`use_with ruby ruby` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog DESIGN NEWS README TODO
}
