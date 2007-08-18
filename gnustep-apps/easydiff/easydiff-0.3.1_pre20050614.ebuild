# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/easydiff/easydiff-0.3.1_pre20050614.ebuild,v 1.2 2007/08/18 15:18:15 angelos Exp $

inherit gnustep subversion

# 25 Mar 2006: 20050614 latest commit in upstream repo

ESVN_OPTIONS="-r{${PV/*_pre}}"
ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/apps/easydiff/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src/svn.gna.org-gnustep/apps/easydiff/trunk"
ESVN_PROJECT=EasyDiff

S=${WORKDIR}/${PN}

DESCRIPTION="GNUstep app that lets you easily see the differences between two text files."
HOMEPAGE="http://www.collaboration-world.com/easydiff/"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}
	dev-util/subversion"

egnustep_install_domain "Local"
