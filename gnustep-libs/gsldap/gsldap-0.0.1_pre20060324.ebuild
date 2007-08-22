# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsldap/gsldap-0.0.1_pre20060324.ebuild,v 1.2 2007/08/22 16:58:13 angelos Exp $

inherit gnustep subversion

ESVN_OPTIONS="-r{${PV/*_pre}}"
ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/libs/${PN}/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src/svn.gna.org-gnustep/libs"

DESCRIPTION="GNUstep LDAP library for open ldap C libraries"
HOMEPAGE="http://www.gnustep.org/"

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="${GS_DEPEND}
	net-nds/openldap"
RDEPEND="${GS_RDEPEND}
	net-nds/openldap"

IUSE=""

egnustep_install_domain "System"

src_unpack() {
	subversion_src_unpack

	cd ${S}
	# Headers location fix
	sed -i -e "s:base/GSCategories.h:GNUstepBase/GSCategories.h:g" GSLDAPCom.h
	sed -i -e "s:gsldap/::g" GSLDAPCom.h
}
