# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.1.3.ebuild,v 1.1 2006/06/03 18:19:20 radek Exp $

inherit zproduct

MY_P="Plone-2.1.3"
DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="app-admin/zope-config"
RDEPEND="
	>=dev-python/imaging-1.1.5
	>=www-client/lynx-2.8.5
	|| (
		=net-zope/zope-2.7*
		=net-zope/zope-2.8*
	)
	"

S="${WORKDIR}/${MY_P}"

ZPROD_LIST="
	ATContentTypes
	ATReferenceBrowserWidget
	Archetypes
	BTreeFolder2
	CMFActionIcons
	CMFCalendar
	CMFCore
	CMFDefault
	CMFDynamicViewFTI
	CMFFormController
	CMFPlone
	CMFQuickInstallerTool
	CMFSetup
	CMFTopic
	CMFUid
	DCWorkflow
	ExtendedPathIndex
	ExternalEditor
	GroupUserFolder
	MimetypesRegistry
	PlacelessTranslationService
	PloneErrorReporting
	PloneLanguageTool
	PloneTranslations
	PortalTransforms
	ResourceRegistries
	SecureMailHost
	generator
	kupu
	validation
	"

pkg_postinst() {
	einfo
	einfo "This Plone version is a bundled version = contains all necessary zope products"
	einfo "You should carefully manage Your zope instance manually(!) with zprod-manager tool"
	einfo "If You have simple installation (just zope and plone) you should safely ;)"
	einfo "run 'zprod-manager add' and mark ${P} as [X] to be added to your instance."
	einfo "Consult http://bugs.gentoo.org/show_bug.cgi?id=105187#c84 for more info."
	einfo
	ewarn "Please do not forget that for python-2.3 (required for zope <2.9) you should:"
	ewarn "  export PYTHON_SLOT_VERSION=2.3"
	ewarn "  emerge imaging"
	ewarn "This will emerge imaging installing it for python-2.3 instead of python-2.4"
	ewarn "You can use this trick also for other python-2.3 packages."
	ewarn
}
