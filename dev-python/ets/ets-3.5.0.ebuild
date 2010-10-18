# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-3.5.0.ebuild,v 1.1 2010/10/18 15:24:51 arfrever Exp $

EAPI="3"

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/ http://pypi.python.org/pypi/ETS"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	>=dev-python/apptools-3.4.0[doc?,examples?]
	>=dev-python/blockcanvas-3.2.0
	>=dev-python/chaco-3.3.2[doc?,examples?]
	>=dev-python/codetools-3.1.2[doc?,examples?]
	>=dev-python/enable-3.3.2[examples?]
	>=dev-python/enthoughtbase-3.0.6[doc?,examples?]
	>=dev-python/envisagecore-3.1.3[doc?,examples?]
	>=dev-python/envisageplugins-3.1.3[examples?]
	>=dev-python/etsdevtools-3.1.0[doc?,examples?]
	>=dev-python/etsprojecttools-0.6.0
	>=sci-visualization/mayavi-3.4.0:2[doc?]
	>=dev-python/scimath-3.0.6
	>=dev-python/traits-3.5.0[doc?,examples?]
	>=dev-python/traitsgui-3.5.0[doc?,examples?]"
