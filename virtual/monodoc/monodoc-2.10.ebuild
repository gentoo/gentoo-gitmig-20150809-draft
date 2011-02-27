# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/monodoc/monodoc-2.10.ebuild,v 1.1 2011/02/27 13:21:07 pacho Exp $

inherit versionator

DESCRIPTION="Virtual for monodoc"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="=dev-lang/mono-$(get_version_component_range 1-2)*"
DEPEND=""
#To-be-finalized
PROPERTIES="virtual"
