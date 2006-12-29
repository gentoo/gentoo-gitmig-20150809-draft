# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.5.1.ebuild,v 1.2 2006/12/29 01:58:28 radek Exp $

inherit zproduct

MY_P="Plone-2.5.1"
DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
HOTFIXES_URI="http://plone.org/products/plone-hotfix/releases/20061031/PloneHotFix20061031.tar.gz"
SRC_URI="mirror://sourceforge/plone/${MY_P}-final.tar.gz
	    $HOTFIXES_URI"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="app-admin/zope-config"
RDEPEND="
	>=dev-python/imaging-1.1.5
	>=www-client/lynx-2.8.5
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
	PloneHotFix20061031
	"

src_compile() {
	# hotfixes to be applied
	cp -a "${WORKDIR}/PloneHotFix20061031/" "${WORKDIR}/${MY_P}/"
}

pkg_postinst() {
	ewarn
	ewarn "This plone version is a bundled version = contains all necessary zope products"
	ewarn "You should carefully manage Your zope instance manually(!) with zprod-manager tool"
	ewarn "If You have simple installation (just zope and plone) you should safely ;)"
	ewarn "execute 'zprod-manager add' and then mark ${P} to be added"
	ewarn
}
