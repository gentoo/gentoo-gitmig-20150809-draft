# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpovmodeler/kpovmodeler-4.0.4.ebuild,v 1.1 2008/05/16 00:11:58 ingmar Exp $

EAPI="1"

KDE_LINGUAS="af ar be bg br ca cs cy da de el en_GB es et eu fa fi fr ga gl he
hr hu is it ja km lt mk ms nb nds ne nl nn oc pl pt pt_BR ro ru se sk sl sr sv
ta tg tr uk vi xh zh_CN zh_TW"

NEED_KDE="${PV}"
inherit kde4-base

# old versions of kpovmodeler are versioned like kde (up to 3.5.9). this is newer and
# hence we need a higher version (4.0.3).
MY_PV="1.1.2"
DESCRIPTION="KPovModeler is a modeling and composition program for creating POV-Ray scenes in KDE."
HOMEPAGE="http://www.kpovmodeler.org"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${PN}-${MY_PV}-kde${PV}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="kde-4"
IUSE="debug htmlhandbook"

PREFIX="${KDEDIR}"

RDEPEND=">=media-libs/freetype-2
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${PN}-${MY_PV}-kde${PV}"
