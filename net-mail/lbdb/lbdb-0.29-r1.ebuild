# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.29-r1.ebuild,v 1.1 2005/03/26 12:22:29 ferdy Exp $

inherit eutils

IUSE="pda ldap finger nis abook crypt"

MY_P=${P/-/_}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/lbdb/"
DEPEND=">=mail-client/mutt-1.2.5"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
DEPEND="dev-lang/perl
	sys-devel/autoconf
	finger? ( net-misc/netkit-fingerd )
	abook? ( app-misc/abook )
	crypt? ( app-crypt/gnupg )
	nis? ( net-nds/yp-tools )"
RDEPEND="pda? ( dev-perl/p5-Palm )
	ldap? ( dev-perl/perl-ldap )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-configure-in.patch" || die "epatch failed"
	ebegin "Rebuilding configure: "
		WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	eend $?
}

src_compile() {
	econf $(use_enable finger) \
		$(use_enable abook) \
		$(use_enable nis ypcat) \
		$(use_enable crypt gpg) \
		--disable-pgp5 --disable-pgp \
		--disable-niscat --disable-addremail --enable-getent \
		--libdir=/usr/lib/lbdb || die
	emake || die
}

src_install () {
	make install_prefix=${D} install || die
	dodoc README INSTALL COPYING NEWS TODO
}
