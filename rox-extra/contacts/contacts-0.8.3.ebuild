# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/contacts/contacts-0.8.3.ebuild,v 1.2 2005/11/19 18:46:22 svyatogor Exp $

DESCRIPTION="Contacts - The ROX Contact Manager"
MY_PN="Contacts"
HOMEPAGE="http://roxos.sunsite.dk/dev-contrib/guido/Contacts/"
SRC_URI="http://roxos.sunsite.dk/dev-contrib/guido/Contacts/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
ROX_LIB_VER=1.9.17
APPNAME=${MY_PN}
S=${WORKDIR}

inherit rox
