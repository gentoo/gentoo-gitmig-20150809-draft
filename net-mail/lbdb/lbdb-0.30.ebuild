# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.30.ebuild,v 1.6 2005/06/10 01:15:44 gustavoz Exp $

inherit eutils

IUSE="pda ldap finger nis abook crypt evo"

MY_P=${P/-/_}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/lbdb/"
DEPEND=">=mail-client/mutt-1.2.5"
SLOT="0"
KEYWORDS="alpha ~ppc sparc x86"
LICENSE="GPL-2"
DEPEND="dev-lang/perl
	evo? ( mail-client/evolution )
	finger? ( net-misc/netkit-fingerd )
	abook? ( app-misc/abook )
	crypt? ( app-crypt/gnupg )
	nis? ( net-nds/yp-tools )"
RDEPEND="pda? ( dev-perl/p5-Palm )
	ldap? ( dev-perl/perl-ldap )"

src_compile() {
	local evoversion

	if useq evo ; then
		evoversion=$(best_version mail-client/evolution)
		evoversion=${evoversion##mail-client/evolution-}
		M_PATH="/usr/libexec/evolution/${evoversion:0:3}/:${PATH}"
	else
		M_PATH=${PATH}
	fi

	PATH=${M_PATH} econf $(use_with finger) \
		$(use_with abook) \
		$(use_with nis ypcat) \
		$(use_with crypt gpg) \
		$(use_with gnome evolution-addressbook-export) \
		--without-pgp5 --without-pgp \
		--without-niscat --without-addr-email --with-getent \
		--libdir=/usr/lib/lbdb || die
	emake || die
}

src_install () {
	make install_prefix=${D} install || die
	dodoc README INSTALL COPYING NEWS TODO
}
