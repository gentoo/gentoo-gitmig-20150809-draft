# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_pcgi2/mod_pcgi2-2.0.2.ebuild,v 1.3 2005/02/25 12:27:33 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache module to talk to Zope Corporation's PCGI"
HOMEPAGE="http://www.zope.org/Members/phd/${PN}/"
SRC_URI="http://zope.org/Members/phd/${PN}/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="www-apps/pcgi"

S=${WORKDIR}/${PN/mod_}

APXS1_ARGS="-Wc,-DMOD_PCGI2 -Wc,-DUNIX -I./ -o mod_pcgi2.so -c mod_pcgi2.c parseinfo.c pcgi-wrapper.c"
APXS2_ARGS="-n pcgi2 -DUNIX -DAPACHE2 -DMOD_PCGI2 -c mod_pcgi2.c pcgi-wrapper.c parseinfo.c "

APACHE1_MOD_CONF="${PVR}/20_mod_pcgi"
APACHE1_MOD_DEFINE="PCGI"

APACHE2_MOD_CONF="${PVR}/20_mod_pcgi"
APACHE2_MOD_DEFINE="PCGI"

DOCFILES="NEWS README TODO ChangeLog"

need_apache
