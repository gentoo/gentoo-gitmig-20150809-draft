# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.04.ebuild,v 1.1 2005/02/09 15:47:30 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn.html"

KEYWORDS="~x86 ~ppc"
SLOT="1"
LICENSE="as-is"
IUSE=""

APACHE1_MOD_CONF="27_mod_limitipconn"
APACHE1_MOD_DEFINE="LIMITIP"

DOCFILES="ChangeLog README"

need_apache1

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || "could not cd to ${S}"

	epatch ${FILESDIR}/${P}-local_ip.patch || "local_ip patch failed"
	epatch ${FILESDIR}/${P}-vhost.patch || "vhost patch failed"
}
