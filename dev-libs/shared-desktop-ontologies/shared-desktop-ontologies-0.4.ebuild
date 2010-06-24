# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shared-desktop-ontologies/shared-desktop-ontologies-0.4.ebuild,v 1.4 2010/06/24 05:38:48 angelos Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Shared OSCAF desktop ontologies"
HOMEPAGE="http://sourceforge.net/projects/oscaf"
SRC_URI="mirror://sourceforge/oscaf/${PN}/${P}.tar.bz2"

LICENSE="BSD CCPL-Attribution-3.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

DOCS=(AUTHORS ChangeLog README)
