# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.85.9.ebuild,v 1.17 2007/01/22 20:04:29 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

IUSE=""

DESCRIPTION="Direct Connect Text Client, almost famous file share program"
HOMEPAGE="http://brainz.servebeer.com/dctc/"
SRC_URI="http://brainz.servebeer.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"

RDEPEND="=dev-libs/glib-2*
	>=sys-libs/db-3
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/dctc-0.85.6-passive.patch
	epatch "${FILESDIR}"/dctc-0.85.9-gcc41.patch

	eautoreconf

	# This fix fails with db-4.3
	if has_version "=sys-libs/db-4.2*" && ! has_version ">=sys-libs/db-4.3*"; then
		local dbfunc="`grep '^#define.*db_env_create' /usr/include/db.h | awk '{print $NF}'`"
		if [ "${dbfunc}" != "db_env_create" ] ; then
			sed -i "s:db_env_create:${dbfunc}:g" configure
		fi
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Documentation/Documentation/* Documentation/Documentation/DCextensions/*
	dodoc AUTHORS ChangeLog KNOWN_BUGS NEWS README TODO
}
