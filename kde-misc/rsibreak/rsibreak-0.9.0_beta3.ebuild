# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.9.0_beta3.ebuild,v 1.1 2008/04/05 16:22:11 philantrop Exp $

EAPI="1"

KDE_LINGUAS="ar be ca cs da de el es et fr ga gl ja km ko nb nds nl nn oc pl pt
pt_BR ro se sk sv tr zh_CN zh_TW"

KDE_PV="4.0.3"
SLOT="kde-4"
NEED_KDE=":${SLOT}"
inherit versionator kde4-base

MY_PV="$(replace_version_separator _ -)"
DESCRIPTION="A small utility which bothers you at certain intervals"
HOMEPAGE="http://www.rsibreak.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${PN}-${MY_PV}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook plasma"

PREFIX="${KDEDIR}"

RDEPEND="x11-libs/libXScrnSaver
	plasma? ( kde-base/plasma:${SLOT} )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${PN}-${MY_PV}"
