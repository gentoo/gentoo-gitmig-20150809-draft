# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/wizardkit/wizardkit-0.1.ebuild,v 1.1 2007/09/10 21:07:11 voyageur Exp $

inherit gnustep-2

MY_PN="WizardKit"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Wizard support framework"
HOMEPAGE="http://home.gna.org/pmanager/"
SRC_URI="http://download.gna.org/pmanager/0.2/${MY_PN}-${PV}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
