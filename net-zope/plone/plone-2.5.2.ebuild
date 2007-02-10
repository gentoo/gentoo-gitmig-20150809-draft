# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.5.2.ebuild,v 1.2 2007/02/10 15:38:39 radek Exp $

inherit zproduct

MY_P="Plone-2.5.2-1"
DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org/"
SRC_URI="http://plone.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="app-admin/zope-config"
RDEPEND="
	>=dev-python/imaging-1.1.5
	>=www-client/lynx-2.8.5
	=net-zope/zope-2.9*
	>=dev-python/elementtree-1.2.6
	"

S="${WORKDIR}/${MY_P}"

ZPROD_LIST="
	Archetypes
	ATContentTypes
	ATReferenceBrowserWidget
	CacheFu
	CMFActionIcons
	CMFCalendar
	CMFCore
	CMFDefault
	CMFDynamicViewFTI
	CMFFormController
	CMFPlacefulWorkflow
	CMFPlone
	CMFQuickInstallerTool
	CMFSetup
	CMFTopic
	CMFUid
	DCWorkflow
	ExtendedPathIndex
	ExternalEditor
	GenericSetup
	GroupUserFolder
	kupu
	Marshall
	MimetypesRegistry
	PasswordResetTool
	PlacelessTranslationService
	PloneErrorReporting
	PloneLanguageTool
	PlonePAS
	PloneTestCase
	PloneTranslations
	PluggableAuthService
	PluginRegistry
	PortalTransforms
	ResourceRegistries
	SecureMailHost
	statusmessages
	validation
	"

pkg_postinst() {
	elog "This plone version is a bundled version = contains all necessary zope products"
	elog "You should carefully manage Your zope instance manually(!) with zprod-manager tool"
	elog "If You have simple installation (just zope and plone) you can safely execute:"
	elog "'zprod-manager add' and then mark ${P} to be added to your instance."
}
