# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-eZcomponents/ezc-eZcomponents-2007.2.1.ebuild,v 1.3 2011/02/12 19:16:29 armin76 Exp $

DESCRIPTION="eZ components is an enterprise ready general purpose PHP platform."
HOMEPAGE="http://ez.no/products/ez_components"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-php5/ezc-Archive-1.2.4
	>=dev-php5/ezc-Authentication-1.1
	>=dev-php5/ezc-AuthenticationDatabaseTiein-1.1
	>=dev-php5/ezc-Base-1.4.1
	>=dev-php5/ezc-Cache-1.3
	>=dev-php5/ezc-Configuration-1.2
	>=dev-php5/ezc-ConsoleTools-1.3.2
	>=dev-php5/ezc-Database-1.3.4
	>=dev-php5/ezc-DatabaseSchema-1.3.1
	>=dev-php5/ezc-Debug-1.1
	>=dev-php5/ezc-EventLog-1.2
	>=dev-php5/ezc-EventLogDatabaseTiein-1.0.2
	>=dev-php5/ezc-Execution-1.1
	>=dev-php5/ezc-File-1.2
	>=dev-php5/ezc-Graph-1.2
	>=dev-php5/ezc-GraphDatabaseTiein-1.0
	>=dev-php5/ezc-ImageAnalysis-1.1.2
	>=dev-php5/ezc-ImageConversion-1.3.3
	>=dev-php5/ezc-Mail-1.4.1
	>=dev-php5/ezc-PersistentObject-1.3.4
	>=dev-php5/ezc-PersistentObjectDatabaseSchemaTiein-1.2.1
	>=dev-php5/ezc-PhpGenerator-1.0.4
	>=dev-php5/ezc-SignalSlot-1.1
	>=dev-php5/ezc-SystemInformation-1.0.5
	>=dev-php5/ezc-Template-1.2
	>=dev-php5/ezc-Translation-1.1.6
	>=dev-php5/ezc-TranslationCacheTiein-1.1.2
	>=dev-php5/ezc-Tree-1.0
	>=dev-php5/ezc-TreeDatabaseTiein-1.0
	>=dev-php5/ezc-TreePersistentObjectTiein-1.0
	>=dev-php5/ezc-Url-1.2
	>=dev-php5/ezc-UserInput-1.2
	>=dev-php5/ezc-Webdav-1.0
	>=dev-php5/ezc-Workflow-1.1
	>=dev-php5/ezc-WorkflowDatabaseTiein-1.1
	>=dev-php5/ezc-WorkflowEventLogTiein-1.1"
