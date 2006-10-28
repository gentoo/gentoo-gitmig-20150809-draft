# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.04.ebuild,v 1.4 2006/10/28 11:56:00 tomk Exp $

inherit eutils apache-module

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted."
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn.html"

KEYWORDS="~x86 ~ppc amd64"
SLOT="1"
LICENSE="as-is"
IUSE=""

APACHE1_MOD_CONF="27_${PN}"
APACHE1_MOD_DEFINE="LIMITIPCONN INFO"

DOCFILES="ChangeLog README"

need_apache1

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || "could not cd to ${S}"

	epatch ${FILESDIR}/${P}-local_ip.patch || "local_ip patch failed"
	epatch ${FILESDIR}/${P}-vhost.patch || "vhost patch failed"
}
