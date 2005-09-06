# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.7.0.ebuild,v 1.1 2005/09/06 21:05:03 sekretarz Exp $

inherit eutils libtool

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://www.gnu.org/software/GNUnet/"
SRC_URI="mirror://gnu//${PN}/GNUnet-${PV}.tar.bz2"
RESTRICT="nomirror"

IUSE="ipv6 mysql sqlite guile nls"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/libgcrypt-1.2.0
	>=media-libs/libextractor-0.5.4
	>=dev-libs/gmp-4.0.0
	sys-libs/zlib
	ncurses? ( sys-libs/ncurses )
	gtk? ( >=x11-libs/gtk+-2.6.10 )
	mysql? ( >=dev-db/mysql-4.0.24 )
	sqlite? ( >=dev-db/sqlite-3.0.8 )
	guile? ( >=dev-util/guile-1.6.0 )
	nls? ( sys-devel/gettext )"

pkg_preinst() {
	enewgroup gnunet || die "Problem adding gnunet group"
	enewuser gnunet -1 -1 /dev/null gnunet || die "Problem adding gnunet user"
}

src_compile() {
#	elibtoolize --copy --force

	local myconf

	if use ipv6; then
		if use amd64; then
			ewarn "ipv6 in GNUnet does not currently work with amd64 and has been disabled"
		else
			myconf="${myconf} --enable-ipv6"
		fi
	fi

	econf \
		$(use_with mysql) \
		$(use_with sqlite) \
		$(use_enable nls) \
		$(use_enable ncurses) \
		$(use_enable gtk) \
		$(use_enable guile) \
		${myconf} || die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS PLATFORMS README	README.fr UPDATING
	insinto /etc
	newins contrib/gnunet.root gnunet.conf
	docinto contrib
	dodoc contrib/*
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnunet-0.7.0 gnunet
	dodir /var/lib/GNUnet
	chown gnunet:gnunet ${D}/var/lib/GNUnet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunet:gnunet /var/lib/GNUnet

	use ipv6 && ewarn "ipv6 support is -very- experimental and prone to bugs"
	einfo
	einfo "To configure"
	einfo "  1) Add user(s) to the gnunet group"
	einfo "  2) Run 'gnunet-setup' to generate your client config file"
	einfo "  3) Run gnunet-setup -d to generate a server config file"
	einfo "  4) Optionally copy the .gnunet/gnunetd.conf into /etc and use as a global server config file"
	einfo
}

