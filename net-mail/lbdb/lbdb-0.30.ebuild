# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.30.ebuild,v 1.9 2006/12/02 21:25:15 beandog Exp $

inherit eutils

IUSE="pda ldap finger nis abook crypt evo"

MY_P=${P/-/_}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/lbdb/"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc sparc x86"
LICENSE="GPL-2"
DEPEND="mail-client/mutt
	dev-lang/perl
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
		$(use_with evo evolution-addressbook-export) \
		--without-pgp5 --without-pgp \
		--without-niscat --without-addr-email --with-getent \
		--libdir=/usr/$(get_libdir)/lbdb || die
	emake || die
}

src_install () {
	make install_prefix=${D} install || die
	dodoc README INSTALL COPYING NEWS TODO
}
