# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.85.9.ebuild,v 1.3 2004/02/04 14:19:45 vapier Exp $

DESCRIPTION="Direct Connect Text Client, almost famous file share program"
HOMEPAGE="http://ac2i.homelinux.com/dctc/"
SRC_URI="http://ac2i.homelinux.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="=dev-libs/glib-2*
	>=sys-libs/db-3
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix for #26708 (db4 support)
	local dbfunc="`nm /usr/lib/libdb.so | grep \ db_env_create | awk '{print $3}'`"
	if [ "${dbfunc}" != "db_env_create" ] ; then
		sed -i "s:db_env_create:${dbfunc}:g" configure
	fi

	epatch ${FILESDIR}/dctc-0.85.6-passive.patch
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc Documentation/* Documentation/DCextensions/*
	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
