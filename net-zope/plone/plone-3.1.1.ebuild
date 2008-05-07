# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-3.1.1.ebuild,v 1.1 2008/05/07 22:25:55 tupone Exp $

inherit versionator zproduct

MY_P="Plone-${PV}"
DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org/"
SRC_URI="https://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="app-admin/zope-config"
RDEPEND=">=dev-python/imaging-1.1.5
	=net-zope/zope-2.10*
	>=net-zope/zope-2.10.5
	dev-python/elementtree
	>=app-admin/zprod-manager-0.3.2"

S="${WORKDIR}/${MY_P}"

ZPROD_LIST="
	Archetypes
	ATContentTypes
	ATReferenceBrowserWidget
	AdvancedQuery
	CMFActionIcons
	CMFCalendar
	CMFCore
	CMFDefault
	CMFDiffTool
	CMFDynamicViewFTI
	CMFEditions
	CMFFormController
	CMFPlacefulWorkflow
	CMFPlone
	CMFQuickInstallerTool
	CMFTestCase
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
	NuPlone
	PasswordResetTool
	PlacelessTranslationService
	PloneLanguageTool
	PlonePAS
	PloneTestCase
	PloneTranslations
	PluggableAuthService
	PluginRegistry
	PortalTransforms
	ResourceRegistries
	SecureMailHost
	ZopeVersionControl
	statusmessages
	validation
	"
ZLPROD_LIST="
	archetypes
	borg
	five
	kss
	plone
	wicked
	"
DOT_ZLFOLDER_FPATH="${ZP_DIR}/${PF}/.zlfolder.lst"

src_install() {
	zproduct_src_install
	for N in ${ZLPROD_LIST} ; do
		echo ${N} >> "${D}"/${DOT_ZLFOLDER_FPATH}
	done
}

pkg_postinst() {
	elog "This plone version is a bundled version = contains all necessary zope products"
	elog "You should carefully manage Your zope instance manually(!) with zprod-manager tool"
	elog "If You have simple installation (just zope and plone) you can safely execute:"
	elog "'zprod-manager add' and then mark ${P} to be added to your instance."
}
