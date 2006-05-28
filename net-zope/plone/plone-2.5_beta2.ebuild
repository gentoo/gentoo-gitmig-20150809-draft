# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.5_beta2.ebuild,v 1.1 2006/05/28 14:11:33 radek Exp $

inherit zproduct

MY_P="Plone-2.5-beta2"
DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="http://plone.org/products/plone/releases/2.5/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="app-admin/zope-config"
RDEPEND="
	>=dev-python/imaging-1.1.5
	=net-zope/zope-2.9*
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
	ewarn
	ewarn "This plone version is a bundled version = contains all necessary zope products"
	ewarn "You should carefully manage Your zope instance manually(!) with zprod-manager tool"
	ewarn "If You have simple installation (just zope and plone) you should safely ;)"
	ewarn "execute 'zprod-manager add' and then mark ${P} to be added"
	ewarn "Consult http://bugs.gentoo.org/show_bug.cgi?id=105187 for more info"
	ewarn
}
