# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gdl2/gdl2-0.9.2_pre20060324.ebuild,v 1.1 2006/03/26 11:02:02 grobian Exp $

inherit gnustep eutils subversion

ESVN_OPTIONS="-r{${PV/*_pre}}"
ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/libs/${PN}/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src/svn.gna.org-gnustep/libs"

DESCRIPTION="GNUstep Database Library 2 (GDL2) for mapping Obj-C to RDBMSes"
HOMEPAGE="http://www.gnustep.org/"

KEYWORDS="~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	!gnustep-apps/sope
	dev-db/postgresql"
RDEPEND="${GS_RDEPEND}
	!gnustep-apps/sope
	dev-db/postgresql"

egnustep_install_domain "System"

src_compile() {
	cd ${S}
	egnustep_env
	econf "--prefix=$(egnustep_prefix)" || die "./configure failed"
	egnustep_make || die
}
